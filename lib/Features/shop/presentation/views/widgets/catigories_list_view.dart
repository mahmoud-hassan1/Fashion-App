import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/Features/shop/presentation/manger/cubit/shop_cubit.dart';
import 'package:online_shopping/Features/shop/presentation/views/products_screen.dart';
import 'package:online_shopping/core/utiles/constants.dart';
import 'package:online_shopping/core/utiles/styles.dart';

// ignore: must_be_immutable
class CatigoriesListView extends StatefulWidget {
  CatigoriesListView({super.key, required this.tabController});
  late TabController tabController;

  @override
  State<CatigoriesListView> createState() => _CatigoriesListViewState();
}

class _CatigoriesListViewState extends State<CatigoriesListView> {
  @override
  void initState() {
    widget.tabController.addListener(
      () {
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              if (index == 0) {
                BlocProvider.of<ShopCubit>(context).fetchNewestProductsByCategory([kTypes[widget.tabController.index].toLowerCase()]);
              } else {
                BlocProvider.of<ShopCubit>(context).fetchProductsByCategory([kCategoryList[index].first.toLowerCase(), kTypes[widget.tabController.index].toLowerCase()]);
              }
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductsScreen(title: "${kTypes[widget.tabController.index]}'s ${kCategoryList[index].first}"),
                  ));
            },
            child: AspectRatio(
              aspectRatio: 3 / 1,
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 24,
                          ),
                          Text(
                            kCategoryList[index].first,
                            style: Styles.kMediumTextStyle(context).copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Image.asset(
                        kCategoryList[index][1][widget.tabController.index],
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        childCount: kCategoryList.length,
      ),
    );
  }
}
