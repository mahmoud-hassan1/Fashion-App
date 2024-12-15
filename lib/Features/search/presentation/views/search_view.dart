import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/Features/search/presentation/manger/qr_code_scanning_cubit/qr_code_scanning_cubit.dart';
import 'package:online_shopping/Features/search/presentation/manger/search_cubit/search_cubit.dart';
import 'package:online_shopping/Features/search/presentation/manger/speech_to_text_cubit/speech_to_text_cubit.dart';
import 'package:online_shopping/Features/search/presentation/views/widgets/result_list_view.dart';
import 'package:online_shopping/Features/search/presentation/views/widgets/search_field.dart';
import 'package:online_shopping/core/utiles/app_colors.dart';
import 'package:online_shopping/core/utiles/styles.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final keyForm = GlobalKey<FormState>();
  final TextEditingController searchText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SpeechToTextCubit speechCubit = BlocProvider.of<SpeechToTextCubit>(context);
    QrCodeScanningCubit qrCubit = BlocProvider.of<QrCodeScanningCubit>(context);
    SearchCubit searchCubit = BlocProvider.of<SearchCubit>(context);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await speechCubit.init();
    });

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const SizedBox(),
          title: Text(
            "Search",
            style: Styles.kFontSize30(context).copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        body: BlocBuilder<QrCodeScanningCubit, QrCodeScanningState>(
          builder: (context, state) {
            return BlocBuilder<SpeechToTextCubit, SpeechToTextState>(
              builder: (context, state) {
                return BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    return CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Row(
                            children: [
                              Expanded(
                                child: SearchField(
                                  onChanged: (value) async => await searchCubit.getResults(value),
                                  searchText: searchText,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  if (speechCubit.isListening) {
                                    await speechCubit.stopListening();
                                  } else {
                                    await speechCubit.startListening((result) async {
                                      searchText.text = result.recognizedWords;
                                      await searchCubit.getResults(searchText.text);
                                    });
                                  }
                                },
                                icon: Icon(
                                  speechCubit.isListening ? Icons.mic : Icons.mic_off,
                                  size: 27,
                                  color: speechCubit.isListening ? AppColors.kRed : Colors.black,
                                ),
                              ),
                              // QR Code Scan Button
                              IconButton(
                                onPressed: () async {
                                  searchText.text = await qrCubit.scanQRCode();
                                  await searchCubit.getResults(searchText.text);
                                },
                                icon: const Icon(
                                  Icons.qr_code_scanner,
                                  size: 27,
                                  color: AppColors.kRed,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (state is SearchLoading)
                          const SliverFillRemaining(
                            child: Center(
                              child: CircularProgressIndicator(
                                color: AppColors.kRed,
                              ),
                            ),
                          ),
                        if (state is SearchSuccess)
                          SliverFillRemaining(
                            child: ResultListView(
                              products: state.products,
                            ),
                          ),
                        if (state is SearchFailed)
                          SliverFillRemaining(
                            child: Center(
                              child: Text(
                                state.errorMessage,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: AppColors.kRed,
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
