import 'dart:math';

import 'package:flutter/material.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/home/presentation/views/home_view/widgets/header_titles.dart';
import 'package:online_shopping/Features/home/presentation/views/home_view/widgets/product_list_view_item.dart';

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
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => ProductListViewItem(
                product: products[index],
              ),
              separatorBuilder: (context, index) => const SizedBox(
                width: 16,
              ),
              itemCount: min(products.length, 5),
            ),
          ),
        ),
      ],
    );
  }
}
