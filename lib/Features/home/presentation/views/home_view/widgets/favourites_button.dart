import 'package:flutter/material.dart';
import 'package:online_shopping/Features/favourite/presentation/cubits/manage_favourites/manage_favourites_cubit.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/core/utiles/app_colors.dart';

class FavouritesButton extends StatelessWidget {
  const FavouritesButton({
    super.key,
    required this.blocInstance,
    required this.product,
  });

  final ManageFavouritesCubit blocInstance;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (blocInstance.isFavourite(productId: product.id)) {
          blocInstance.removeFromFavourites(product.id);
        } else {
          blocInstance.addToFavourites(product.id);
        }
      },
      child: Container(
        margin: const EdgeInsets.all(3),
        padding: const EdgeInsets.all(3),
        decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.kItemBackgroundColor, boxShadow: [BoxShadow(blurRadius: 5, color: Colors.grey, offset: Offset(4, 4))]),
        child: Icon(blocInstance.isFavourite(productId: product.id) ? Icons.favorite : Icons.favorite_border_rounded,
            color: blocInstance.isFavourite(productId: product.id) ? AppColors.kRed : Colors.black),
      ),
    );
  }
}
