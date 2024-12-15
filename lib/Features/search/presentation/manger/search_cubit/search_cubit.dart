import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';


import '../../../domain/repo/search_repo.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.searchRepo) : super(SearchInitial());
  static SearchCubit get(context)=>BlocProvider.of(context);
 final SearchRepo searchRepo;

  Future<void> getResults(String search) async{
    emit(SearchLoading());

    final response  = await searchRepo.getSearchResult(search);
    if(response.isEmpty){
      emit(SearchFailed(errorMessage: "NO Results found"));
    }else{
      emit(SearchSuccess(products: response));
    }


  }
}
