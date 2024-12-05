import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:online_shopping/Features/favourite/domain/use_cases/add_to_favourites.dart';
import 'package:online_shopping/Features/favourite/domain/use_cases/remove_from_favourites.dart';
import 'package:online_shopping/Features/favourite/domain/use_cases/get_favourites_poducts.dart';
import 'package:online_shopping/Features/favourite/data/repo_impl/favourite_repo_impl.dart';
import 'package:online_shopping/core/models/user_model.dart';

part 'manage_favourites_state.dart';

class ManageFavouritesCubit extends Cubit<ManageFavouritesState> {
  final AddToFavouritesUseCase addToFavouritesUseCase;
  final RemoveFromFavouritesUseCase removeFromFavouritesUseCase;


  ManageFavouritesCubit({
    required this.addToFavouritesUseCase,
    required this.removeFromFavouritesUseCase,
  }) : super(ManageFavouritesInitial());

  Future<void> addToFavourites( String productId) async {
    try {
      await addToFavouritesUseCase.call(UserModel.getInstance().uid, productId);
      if(UserModel.getInstance().favourites!=null) {
        UserModel.getInstance().favourites!.add(productId);
      } else{
        UserModel.getInstance().favourites=[productId, productId];
       }
      emit(ManageFavouritesSuccess());
    } catch (e) {
      emit(ManageFavouritesError(error: 'Failed to add to favourites: $e'));
    }
  }

  Future<void> removeFromFavourites( String productId) async {
    try {
      await removeFromFavouritesUseCase.call(UserModel.getInstance().uid, productId);
      UserModel.getInstance().favourites!.remove(productId);
      emit(ManageFavouritesSuccess());
    } catch (e) {
      emit(ManageFavouritesError(error: 'Failed to remove from favourites: $e'));
    }
  } 
  bool isFavourite({required String productId})  {
    if (UserModel.getInstance().favourites!=null){
      return  UserModel.getInstance().favourites!.contains(productId) ;
    }
      else{
        return false;
      }
      

  }
}
