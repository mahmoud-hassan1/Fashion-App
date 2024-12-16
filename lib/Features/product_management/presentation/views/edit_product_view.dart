import 'package:flutter/material.dart';
import 'package:online_shopping/Features/product_management/presentation/views/widgets/edit_product_body.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';

class EditProductView extends StatelessWidget {
  const EditProductView({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EditProductBody(product: product),
    );
  }
}
