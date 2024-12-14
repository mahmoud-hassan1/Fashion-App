import 'dart:math';

import 'package:flutter/material.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/home/presentation/views/home_view/widgets/header_titles.dart';
import 'package:online_shopping/Features/home/presentation/views/home_view/widgets/product_list_view_item.dart';
import 'package:online_shopping/core/utiles/styles.dart';

class ProductListView extends StatelessWidget {
  const ProductListView({super.key, required this.products, required this.title});
  final List<Product> products;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Header(
          title: title,
          products: products,
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 200,
          child: products.isNotEmpty? ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  const SizedBox(width: 16),
                  ProductListViewItem(product: products[index]),
                  index == min(products.length, 5) - 1 ? const SizedBox(width: 16) : const SizedBox(),
                ],
              );
            },
            itemCount: min(products.length, 5),
          ):  Text("No Products Yet", style: Styles.kMediumTextStyle(context)),
        ),
      ],
    );
  }
}
