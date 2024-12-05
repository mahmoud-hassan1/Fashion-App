import 'package:flutter/material.dart';
import 'package:online_shopping/Features/reviews/data/models/review_model.dart';
import 'package:online_shopping/Features/reviews/presentation/views/widgets/product_reviews_view_body.dart';

class ProductReviewsView extends StatelessWidget {
  const ProductReviewsView({super.key, required this.reviews});

  final List<ReviewModel> reviews;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProductReviewsViewBody(reviews: reviews),
    );
  }
}
