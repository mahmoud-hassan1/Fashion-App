import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/Features/favourite/presentation/cubits/manage_favourites/manage_favourites_cubit.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/home/presentation/views/home_view/widgets/favourites_button.dart';
import 'package:online_shopping/core/models/user_model.dart';
import 'package:online_shopping/core/utiles/app_colors.dart';
import 'package:online_shopping/core/utiles/routes.dart';
import 'package:online_shopping/core/utiles/styles.dart';
import 'package:online_shopping/core/widgets/snackbar.dart';

class ProductListViewItem extends StatelessWidget {
  const ProductListViewItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AppRouter.productDetailsView(product),
          ),
        );

        if (context.mounted) {
          BlocProvider.of<ManageFavouritesCubit>(context).emitState();
        }
      },
      child: SizedBox(
        height: 200,
        width: 121,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                children: [
                  SizedBox(
                    height: 123,
                    width: 121,
                    child: CachedNetworkImage(
                      imageUrl: product.image,
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      fit: BoxFit.fill,
                    ),
                  ),
                  BlocConsumer<ManageFavouritesCubit, ManageFavouritesState>(
                    listener: (context, state) {
                      if (state is ManageFavouritesError) {
                        snackBar(content: state.error, context: context);
                      }
                    },
                    builder: (context, state) {
                      final blocInstance = BlocProvider.of<ManageFavouritesCubit>(context);
                      return Positioned(
                        top: 5,
                        right: 5,
                        child: FavouritesButton(blocInstance: blocInstance, product: product),
                      );
                    },
                  ),
                  UserModel.getInstance().role == Role.admin
                      ? IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AppRouter.editProductView(product),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit))
                      : const SizedBox()
                ],
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              product.name,
              style: Styles.kSmallTextStyle(context).copyWith(fontSize: 15),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Row(
              children: [
                Flexible(
                  flex: 2,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      product.price == product.price.toInt() ? "\$${product.price.toInt()}" : "\$${product.price}",
                      style: Styles.kMediumTextStyle(context).copyWith(fontWeight: FontWeight.w700),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 3,
                ),
                product.discount > 0
                    ? Flexible(
                        flex: 1,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            product.priceBeforeDiscount == product.priceBeforeDiscount.toInt() ? "\$${product.priceBeforeDiscount.toInt()}" : "\$${product.priceBeforeDiscount}",
                            style: Styles.kFontSize17(context).copyWith(fontWeight: FontWeight.w500, decoration: TextDecoration.lineThrough, color: AppColors.kSeconderyTextColor),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
