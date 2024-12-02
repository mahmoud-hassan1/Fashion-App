import 'package:flutter/material.dart';
import 'package:online_shopping/core/utiles/app_colors.dart';
import 'package:online_shopping/core/utiles/styles.dart';

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
            style: Styles.kSmallTextStyle(context),
          ),
        ),
        Tab(
          child: Text(
            "Men",
            style: Styles.kSmallTextStyle(context),
          ),
        ),
        Tab(
          child: Text(
            "Kids",
            style: Styles.kSmallTextStyle(context),
          ),
        ),
      ],
      indicatorColor: AppColors.kRed,
    );
  }
}
