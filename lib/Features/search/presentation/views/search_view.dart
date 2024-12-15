import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/Features/search/presentation/views/widgets/result_list_view.dart';
import 'package:online_shopping/Features/search/presentation/views/widgets/search_field.dart';
import 'package:online_shopping/core/utiles/styles.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../../../core/utiles/app_colors.dart';
import '../../../../core/utiles/firebase_firestore_services.dart';
import '../../data/repo_impl/search_repo_impl.dart';
import '../manger/search_cubit/search_cubit.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final keyForm = GlobalKey<FormState>();
  final TextEditingController searchText = TextEditingController();
  final SpeechToText _speechToText = SpeechToText();

  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      searchText.text = _lastWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Search",
            style: Styles.kFontSize30(context)
                .copyWith(fontWeight: FontWeight.w600),
          ),
          leading: const SizedBox(),
        ),
        body: BlocProvider(
          create: (context) => SearchCubit(
            SearchRepoImpl(
              fireStoreServices: FirestoreServices(),
            ),
          ),
          child: BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              var cubit = SearchCubit.get(context);

              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Row(
                      children: [
                        Expanded(
                          child: SearchField(
                            onChanged: (value) => cubit.getResults(value),
                            searchText: searchText,

                          ),
                        ),
                        IconButton(
                          onPressed: _speechToText.isNotListening
                          ? _startListening
                              : _stopListening,
                          icon:  Icon(
                            _speechToText.isNotListening
                                ? Icons.mic_off
                                : Icons.mic,
                            size: 27,
                            color: _speechToText.isNotListening
                                ? Colors.black
                                : AppColors.kRed,
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
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.kRed,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
