import 'package:flutter/material.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/reviews/presentation/views/widgets/add_product_review.dart';
import 'package:online_shopping/Features/reviews/presentation/views/widgets/write_review_floating_button.dart';
import 'package:online_shopping/Features/reviews/presentation/views/widgets/product_reviews_view_body.dart';

// ignore: must_be_immutable
class ProductReviewsView extends StatelessWidget {
  ProductReviewsView({super.key, required this.product});

  Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(forceMaterialTransparency: true),
      body: ProductReviewsViewBody(product: product),
      floatingActionButton: WriteReviewFloatingButton(
        product: product,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => AddProductReview(product: product),
            ),
          );
        },
      ),
    );
  }
}
