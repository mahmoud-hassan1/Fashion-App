import 'package:flutter/material.dart';
import 'package:online_shopping/core/utiles/app_colors.dart';
import 'package:online_shopping/core/utiles/font.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: [
        Tab(
          child: Text(
            "Women",
            style: FontStyles.kSmallTextStyle(context),
          ),
        ),
        Tab(
          child: Text(
            "Men",
            style: FontStyles.kSmallTextStyle(context),
          ),
        ),
        Tab(
          child: Text(
            "Kids",
            style: FontStyles.kSmallTextStyle(context),
          ),
        ),
      ],
      indicatorColor: AppColors.kRed,
    );
  }
}
