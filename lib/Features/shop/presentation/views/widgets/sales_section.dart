import 'package:flutter/material.dart';
import 'package:online_shopping/core/utiles/app_colors.dart';
import 'package:online_shopping/core/utiles/font.dart';

class SalesSection extends StatelessWidget {
  const SalesSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: AspectRatio(
        aspectRatio: 3 / 1,
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.kRed,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "SUMMER SALES",
                style: FontStyles.kFontSize30(context).copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Up to 50% off",
                style: FontStyles.kSmallTextStyle(context)
                    .copyWith(color: Colors.white)
                    .copyWith(fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
