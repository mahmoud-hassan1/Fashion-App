import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/Features/favourite/presentation/cubits/manage_favourites/manage_favourites_cubit.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/core/utiles/app_colors.dart';
import 'package:online_shopping/core/utiles/styles.dart';

class FavouritesItem extends StatelessWidget {

  final Product product;
  const FavouritesItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 113.h,
        ),
        Container(
          height: 100.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 100.h,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    child: Image.network(
                      product.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
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
                        const SizedBox(
                          width: 4,
                        ),
                        Row(
                          children: [
                            RatingBarIndicator(
                              rating: product.rate,
                              itemSize: 15.r,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                            ),
                            Text(
                              "${product.rate}",
                              style: Styles.kFontSize17(context).copyWith(
                                color: AppColors.kSeconderyTextColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              width: 47.r,
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
            top: 4,
            right: 4,
            child: IconButton(
                onPressed: () {
                BlocProvider.of<ManageFavouritesCubit>(context).removeFromFavourites(product.id);
                },
                icon: Icon(
                  Icons.close,
                  color: AppColors.kSeconderyTextColor,
                  size: 25.r,
                ))),
        Positioned(
          bottom: 0,
          right: 0,
          child: IconButton(
            icon: const Icon(
              Icons.shopping_bag,
              color: Colors.white,
            ),
            onPressed: () {},
            style: IconButton.styleFrom(
                backgroundColor: AppColors.kRed,
                iconSize: 24.r,
                padding: const EdgeInsets.all(10)),
          ),
        )
      ],
    );
  }
}
