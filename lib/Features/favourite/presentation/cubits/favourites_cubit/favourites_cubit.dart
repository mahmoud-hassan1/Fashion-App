import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/favourite/domain/use_cases/get_favourites_poducts.dart';

part 'favourites_state.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  final GetFavouritesPoductsUseCase getFavouritesPoductsUseCase;

  FavouritesCubit({required this.getFavouritesPoductsUseCase}) : super(FavouritesInitial());

  Future<void> getFavouritesProducts() async {
    print("sssssssssssssssssssssssssssssssssss");
    emit(FavouritesLoading());
    try {
      final products = await getFavouritesPoductsUseCase.call();
      print("anything");
      print(products);
      emit(FavouritesSuccess(products));
    } catch (e) {
      print("something went wrong");
      emit(FavouritesFail('Failed to load favourites products: $e'));
    }
  }
}
