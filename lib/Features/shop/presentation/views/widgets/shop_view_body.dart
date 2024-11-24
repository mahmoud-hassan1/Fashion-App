import 'package:flutter/material.dart';
import 'package:online_shopping/Features/shop/presentation/views/widgets/catigories_list_view.dart';
import 'package:online_shopping/Features/shop/presentation/views/widgets/custom_tab_bar.dart';
import 'package:online_shopping/Features/shop/presentation/views/widgets/sales_section.dart';
// ignore: must_be_immutable
class ShopViewBody extends StatelessWidget {
  ShopViewBody({super.key});
  late TabController tabController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
    DefaultTabController(
      length: 3,
      child: Builder(
        builder: (BuildContext context) {
           tabController = DefaultTabController.of(context);
          return const CustomTabBar();
        }
        )),
        const Expanded( 
          child: CustomScrollView(
            slivers: <Widget>[
              SalesSection(),
              CatigoriesListView(),
            ],
          ),
        ),
      ],
    );
  }
}


