import 'package:flutter/material.dart';
import 'package:online_shopping/Features/shop/presentation/views/widgets/shop_view_body.dart';
import 'package:online_shopping/core/utiles/styles.dart';

class ShopView extends StatelessWidget {
  const ShopView({super.key});

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
      
      ),
      body: ShopViewBody(),
    );
  }
}