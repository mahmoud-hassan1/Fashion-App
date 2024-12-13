import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/Features/favourite/data/repo_impl/favourite_repo_impl.dart';
import 'package:online_shopping/Features/favourite/domain/repo_interface/favourite_repo.dart';
import 'package:online_shopping/Features/favourite/domain/use_cases/add_to_favourites.dart';
import 'package:online_shopping/Features/favourite/domain/use_cases/remove_from_favourites.dart';
import 'package:online_shopping/Features/favourite/presentation/cubits/manage_favourites/manage_favourites_cubit.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/shop/presentation/views/widgets/products_screen_body.dart';
import 'package:online_shopping/core/utiles/styles.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key, required this.title, this.products});
  final List<Product>? products;
  final String title;

  @override
  Widget build(BuildContext context) {
    final FavouriteRepo favouriteRepo = FavouriteRepoImpl(firestore: FirebaseFirestore.instance);
    return BlocProvider(
      create: (context) => ManageFavouritesCubit(addToFavouritesUseCase: AddToFavouritesUseCase(favouriteRepo), removeFromFavouritesUseCase: RemoveFromFavouritesUseCase(favouriteRepo)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(title, style: Styles.kFontSize30(context).copyWith(fontWeight: FontWeight.w600)),
          centerTitle: true,
        ),
        body: ProductsScreenBody(
          products: products,
        ),
      ),
    );
  }
}
