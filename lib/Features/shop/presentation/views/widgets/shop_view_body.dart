import 'package:flutter/material.dart';
import 'package:online_shopping/Features/shop/presentation/views/widgets/catigories_list_view.dart';
import 'package:online_shopping/Features/shop/presentation/views/widgets/sales_section.dart';

// ignore: must_be_immutable
class ShopViewBody extends StatelessWidget {
  ShopViewBody({super.key, required this.tabController});
  late TabController tabController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: CustomScrollView(
        slivers: <Widget>[
          SalesSection(
            tabController: tabController,
          ),
          CatigoriesListView(
            tabController: tabController,
          ),
        ],
      ),
    );
  }
}
