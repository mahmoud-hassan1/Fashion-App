import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/Features/search/presentation/views/widgets/result_list_view.dart';
import 'package:online_shopping/Features/search/presentation/views/widgets/search_field.dart';
import 'package:online_shopping/core/utiles/styles.dart';
import '../../../../core/utiles/app_colors.dart';
import '../../../../core/utiles/firebase_firestore_services.dart';
import '../../data/repo_impl/search_repo_impl.dart';
import '../manger/search_cubit/search_cubit.dart';

class SearchView extends StatelessWidget {
  SearchView({super.key});

  final keyForm = GlobalKey<FormState>();
  final TextEditingController searchText = TextEditingController();

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
                    child: SearchField(
                      onChanged: (value) => cubit.getResults(value),
                      searchText: searchText,
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
