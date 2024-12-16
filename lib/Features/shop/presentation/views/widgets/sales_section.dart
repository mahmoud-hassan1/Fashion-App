import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/Features/shop/presentation/manger/cubit/shop_cubit.dart';
import 'package:online_shopping/core/utiles/app_colors.dart';
import 'package:online_shopping/core/utiles/constants.dart';
import 'package:online_shopping/core/utiles/routes.dart';
import 'package:online_shopping/core/utiles/styles.dart';

// ignore: must_be_immutable
class SalesSection extends StatelessWidget {
  SalesSection({
    required this.tabController,
    super.key,
  });
  late TabController tabController;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: InkWell(
        onTap: () {
          BlocProvider.of<ShopCubit>(context).fetchSaleProductsByCategory([kTypes[tabController.index].toLowerCase()]);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AppRouter.productsScreen("${kTypes[tabController.index]}'s Sales", null),
              ));
        },
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
                  style: Styles.kFontSize30(context).copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Up to 50% off",
                  style: Styles.kSmallTextStyle(context).copyWith(color: Colors.white).copyWith(fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
