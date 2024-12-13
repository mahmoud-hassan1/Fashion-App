import 'package:flutter/material.dart';
import 'package:online_shopping/core/utiles/styles.dart';

class ProductsStatistics extends StatelessWidget {
  const ProductsStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Product Statistics", style: Styles.kMediumTextStyle(context).copyWith(fontSize: 34)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
