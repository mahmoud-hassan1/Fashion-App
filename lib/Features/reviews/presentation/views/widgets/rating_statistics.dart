import 'package:flutter/material.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/reviews/data/models/product_review_model.dart';
import 'package:online_shopping/Features/reviews/presentation/views/widgets/stars.dart';
import 'package:online_shopping/core/utiles/styles.dart';

class RatingStatistics extends StatelessWidget {
  const RatingStatistics({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          child: Column(
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  product.rate.toStringAsFixed(1),
                  style: Styles.kLargeTextStyle(context),
                ),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "${product.reviews.length.toString()} ratings",
                  style: Styles.kFontSize17(context).copyWith(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            for (int i = 5; i >= 1; i--)
              Row(
                children: [
                  Stars(
                    numberOfStars: i,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    getNumOfReviews(product.reviews, i).toString(),
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }

  int getNumOfReviews(List<ReviewModel> reviews, int stars) {
    int sum = 0;

    for (ReviewModel review in reviews) {
      if (review.rate == stars) {
        sum++;
      }
    }

    return sum;
  }
}
