import 'package:online_shopping/Features/favourite/domain/repo_interface/favourite_repo.dart';

class AddToFavouritesUseCase {
  final FavouriteRepo repository;

  AddToFavouritesUseCase(this.repository);

  Future<void> call(String userId, String productId) async {
    try {
      await repository.addToFavourites(userId, productId);
    } catch (e) {
      throw Exception('Failed to add to favourites: $e');
    }
  }
}

