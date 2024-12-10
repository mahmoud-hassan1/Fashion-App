import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:online_shopping/Features/favourite/presentation/cubits/manage_favourites/manage_favourites_cubit.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/home/presentation/views/home_view/widgets/favourites_button.dart';
import 'package:online_shopping/core/utiles/app_colors.dart';
import 'package:online_shopping/core/utiles/styles.dart';
import 'package:online_shopping/core/widgets/custom_rating_bar.dart';
import 'package:online_shopping/core/widgets/snackbar.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        SizedBox(
          height: 113.h,
        ),
        Container(
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
                    child: Image.network(
                      product.image,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 24),
                    Text(
                      product.name,
                      style: Styles.kMediumTextStyle(context),
                    ),
                    Row(
                          children: [
                            CustomRatingBar(product: product),
                            Text(
                              "(${product.rate})",
                              style: Styles.kFontSize17(context).copyWith(
                                color: AppColors.kSeconderyTextColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(width: 47.r)
                          ],
                        ),
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
                       
                      ],
                    ),
                    const SizedBox(height: 8)
                  ],
                ),
              )
            ],
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
                        bottom: 5,
                        right: 5,
                        child: FavouritesButton(blocInstance: blocInstance, product: product),
                      );
                    },
                  )
      ],
    );
  }
}