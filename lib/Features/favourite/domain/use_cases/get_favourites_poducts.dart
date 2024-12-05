import 'package:online_shopping/Features/favourite/domain/repo_interface/favourite_repo.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';

class GetFavouritesPoductsUseCase {
  final FavouriteRepo repository;

  GetFavouritesPoductsUseCase(this.repository);

  Future<List<Product>> call() async {
    try {
      final products = await repository.getFavouritsProduct();
      return products;
    } catch (e) {
      throw Exception('Failed to load newest products: $e'); 
    }
  }
}

