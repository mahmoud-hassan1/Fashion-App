import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:online_shopping/Features/reviews/data/models/product_review_model.dart';
import 'package:online_shopping/core/utiles/styles.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({super.key, required this.reviewModel});

  final ProductReviewModel reviewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ClipRRect(
                clipBehavior: Clip.hardEdge,
                child: CircleAvatar(
                  radius: 16,
                  foregroundImage: NetworkImage(reviewModel.profilePicture),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(reviewModel.userName),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      RatingBarIndicator(
                        itemCount: 5,
                        itemSize: 12,
                        unratedColor: Colors.orangeAccent,
                        itemBuilder: (BuildContext context, int index) {
                          if (reviewModel.rate > index) {
                            return const Icon(Icons.star, color: Colors.orangeAccent);
                          } else {
                            return const Icon(Icons.star, color: Colors.black26);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const Expanded(child: SizedBox(width: 10)),
              Text(
                "${reviewModel.dateTime.day}/${reviewModel.dateTime.month}/${reviewModel.dateTime.year}",
                style: Styles.kFontSize14(context).copyWith(color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            reviewModel.review,
            style: Styles.kFontSize14(context).copyWith(color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
