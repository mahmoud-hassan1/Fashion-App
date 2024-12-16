import 'package:flutter/material.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/shop/presentation/views/widgets/products_screen_body.dart';
import 'package:online_shopping/core/utiles/styles.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key, required this.title, this.products});
  final List<Product>? products;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: Styles.kFontSize30(context).copyWith(fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: ProductsScreenBody(
        products: products,
      ),
    );
  }
}
