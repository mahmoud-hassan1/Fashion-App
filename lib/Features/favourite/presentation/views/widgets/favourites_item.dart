import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/core/utiles/app_colors.dart';
import 'package:online_shopping/core/utiles/assets.dart';
import 'package:online_shopping/core/utiles/styles.dart';

class FavouritesItem extends StatelessWidget {
  const FavouritesItem({
    super.key,
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
                    child: Image.asset(
                      Assets.imagesClothes,
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
                      "Shirt",
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
                              "\$99.99",
                              style: Styles.kMediumTextStyle(context),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Row(
                          children: [
                            RatingBarIndicator(
                              rating: 4.5,
                              itemSize: 15.r,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                            ),
                            Text(
                              "(4.5)",
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
                onPressed: () {},
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
                padding: EdgeInsets.all(10)),
          ),
        )
      ],
    );
  }
}
