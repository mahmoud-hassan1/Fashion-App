import 'package:online_shopping/Features/favourite/domain/repo_interface/favourite_repo.dart';

class RemoveFromFavouritesUseCase {
  final FavouriteRepo repository;

  RemoveFromFavouritesUseCase(this.repository);

  Future<void> call(String userId, String productId) async {
    try {
      await repository.removeFromFavourites(userId, productId);
    } catch (e) {
      throw Exception('Failed to remove from favourites: $e');
    }
  }
}

