import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:online_shopping/Features/reviews/data/models/review_model.dart';
import 'package:online_shopping/Features/reviews/presentation/views/widgets/review_text_field.dart';
import 'package:online_shopping/constants.dart';
import 'package:online_shopping/core/models/user_model.dart';
import 'package:online_shopping/core/utiles/styles.dart';
import 'package:online_shopping/core/widgets/custtom_button.dart';
import 'package:online_shopping/core/widgets/scale_down.dart';
import 'package:online_shopping/core/widgets/snackbar.dart';

class AddReview extends StatelessWidget {
  AddReview({super.key});

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int rating = 0;
    return Scaffold(
      backgroundColor: const Color(0xfff9f9f9),
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: ScaleDown(
          child: Text(
            "What is you rate?",
            style: Styles.kSmallTextStyle(context).copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Flexible(
                  child: Column(
                    children: [
                      RatingBar(
                        ratingWidget: RatingWidget(
                          full: const Icon(Icons.star_rounded, color: Colors.orangeAccent),
                          half: const Column(),
                          empty: const Icon(Icons.star_border_rounded, color: Colors.grey),
                        ),
                        allowHalfRating: false,
                        onRatingUpdate: (double rate) {
                          rating = rate.toInt();
                        },
                      ),
                      const SizedBox(height: 15),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "Please share your opinion\nabout the product",
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: Styles.kSmallTextStyle(context).copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 5), spreadRadius: -7),
                          ],
                        ),
                        child: ReviewTextField(controller: controller),
                      ),
                      const Expanded(child: SizedBox(height: 15)),
                      CustomButton(
                        onTap: () {
                          if (controller.text.isNotEmpty) {
                            final ReviewModel reviewModel = ReviewModel(
                              review: controller.text,
                              dateTime: DateTime.now(),
                              rate: rating,
                              userName: UserModel.getInstance().name,
                              profilePicture: UserModel.getInstance().profilePicturePath ?? defaultProfileImage,
                            );
                          } else {
                            snackBar(content: "Please, Write a review", context: context);
                          }
                        },
                        height: 550,
                        label: "SEND REVIEW",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
