import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/Features/shop/data/data_source/shop_data_source.dart';
import 'package:online_shopping/Features/shop/data/repo/shop_repo_impl.dart';
import 'package:online_shopping/Features/shop/domain/use_cases/get_newest_products_by_cat.dart';
import 'package:online_shopping/Features/shop/domain/use_cases/get_products_by_cat.dart';
import 'package:online_shopping/Features/shop/presentation/manger/cubit/shop_cubit.dart';
import 'package:online_shopping/Features/shop/presentation/views/widgets/shop_view_body.dart';
import 'package:online_shopping/core/utiles/app_colors.dart';
import 'package:online_shopping/core/utiles/constants.dart';
import 'package:online_shopping/core/utiles/styles.dart';

// ignore: must_be_immutable
class ShopView extends StatefulWidget {
   ShopView({super.key});
 late TabController _tabController;
  @override
  State<ShopView> createState() => _ShopViewState();
}

class _ShopViewState extends State<ShopView>   with SingleTickerProviderStateMixin{
  @override
  void initState() {
   widget._tabController=  TabController(length: kTypes.length, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Categories',
          style: Styles.kFontSize30(context).copyWith(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        bottom:  TabBar(
          controller: widget._tabController,
          tabAlignment: TabAlignment.fill,
          isScrollable: false,
          indicatorColor: AppColors.kRed,
          dividerColor: Colors.transparent,
      
          tabs: kTypes
              .map((category) => Tab(
                    
                    child: Text(
                      category,
                      style: Styles.kSmallTextStyle(context),
                    ),
                  ))
              .toList(),
        ),
      ),
      body: ShopViewBody(tabController:widget._tabController),
    );
  }
}