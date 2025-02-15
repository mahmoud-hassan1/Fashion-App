import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/core/utiles/app_colors.dart';
import 'package:online_shopping/core/utiles/routes.dart';
import 'package:online_shopping/core/utiles/styles.dart';
import 'package:online_shopping/core/widgets/custom_rating_bar.dart';

class ResultItem extends StatelessWidget {
  const ResultItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 113.h,
        ),
        InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AppRouter.productDetailsView(product),
            ),
          ),
          child: Container(
            height: 100.h,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 100.h,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                      child: CachedNetworkImage(
                        imageUrl: product.image,
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      Text(
                        product.name,
                        style: Styles.kMediumTextStyle(context),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "\$${product.price}",
                                style: Styles.kMediumTextStyle(context),
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Row(
                            children: [
                              CustomRatingBar(product: product),
                              Text(
                                "${product.rate}",
                                style: Styles.kFontSize17(context).copyWith(
                                  color: AppColors.kSeconderyTextColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(width: 47.r)
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        // Positioned(
        //   top: 4,
        //   right: 4,
        //   child: IconButton(
        //     onPressed: () async {
        //       await BlocProvider.of<ManageFavouritesCubit>(context).removeFromFavourites(product.id);
        //     },
        //     icon: Icon(
        //       Icons.close,
        //       color: AppColors.kSeconderyTextColor,
        //       size: 25.r,
        //     ),
        //   ),
        // ),
        // Positioned(
        //   bottom: 0,
        //   right: 0,
        //   child: IconButton(
        //     icon: const Icon(
        //       Icons.shopping_bag,
        //       color: Colors.white,
        //     ),
        //     onPressed: () async {
        //       await BlocProvider.of<AddToCartCubit>(context).addToCart(product.id);
        //     },
        //     style: IconButton.styleFrom(
        //       backgroundColor: AppColors.kRed,
        //       iconSize: 24.r,
        //       padding: const EdgeInsets.all(10),
        //     ),
        //   ),
        // )
      ],
    );
  }
}
