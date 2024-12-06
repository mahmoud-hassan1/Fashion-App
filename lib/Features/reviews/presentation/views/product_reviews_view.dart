import 'package:flutter/material.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/reviews/presentation/views/widgets/add_review.dart';
import 'package:online_shopping/Features/reviews/presentation/views/widgets/product_reviews_view_body.dart';
import 'package:online_shopping/core/utiles/styles.dart';

class ProductReviewsView extends StatelessWidget {
  const ProductReviewsView({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      body: ProductReviewsViewBody(product: product),
      floatingActionButton: SizedBox(
        height: 33,
        child: FloatingActionButton.extended(
          onPressed: () async {
            await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddReview()));
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          backgroundColor: const Color(0xFFDB3022),
          icon: const Icon(Icons.edit, color: Colors.white, size: 20),
          label: Text(
            "Write a review",
            style: Styles.kFontSize14(context).copyWith(color: Colors.white, inherit: false),
          ),
        ),
      ),
    );
  }
}
