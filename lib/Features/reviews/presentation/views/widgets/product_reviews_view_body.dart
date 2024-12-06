import 'package:flutter/material.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/reviews/presentation/views/widgets/rating_statistics.dart';
import 'package:online_shopping/Features/reviews/presentation/views/widgets/review_item.dart';
import 'package:online_shopping/core/utiles/styles.dart';

class ProductReviewsViewBody extends StatelessWidget {
  const ProductReviewsViewBody({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text('Rating&Reviews', style: Styles.kLargeTextStyle(context)),
          ),
          const SizedBox(height: 24),
          RatingStatistics(product: product),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: product.reviews.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    ReviewItem(reviewModel: product.reviews[index]),
                    const SizedBox(height: 15),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
