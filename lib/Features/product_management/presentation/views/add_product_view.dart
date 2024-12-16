import 'package:flutter/material.dart';
import 'package:online_shopping/Features/product_management/presentation/views/widgets/add_product_body.dart';

class AddProductView extends StatelessWidget {
  const AddProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AddProductBody(),
    );
  }
}
