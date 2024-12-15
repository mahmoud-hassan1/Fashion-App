import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/search/domain/repo/speech_to_text_repo.dart';
import 'package:online_shopping/features/search/domain/repo/search_repo.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.searchRepo, this.speechToTextRepo) : super(SearchInitial());

  final SearchRepo searchRepo;
  final SpeechToTextRepo speechToTextRepo;

  Future<void> getResults(String search) async {
    try {
      emit(SearchLoading());

      final response = await searchRepo.getSearchResult(search);
      if (response.isEmpty) {
        emit(SearchFailed("NO Results found"));
      } else {
        emit(SearchSuccess(response));
      }
    } catch (_) {
      emit(SearchFailed("Something went wrong"));
    }
  }
}
