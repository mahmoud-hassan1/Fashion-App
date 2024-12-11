import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/product_details/presentation/cubits/product_details_cubit/product_details_cubit.dart';
import 'package:online_shopping/Features/reviews/data/models/product_review_model.dart';
import 'package:online_shopping/Features/reviews/presentation/cubits/product_reviews_cubit/product_reviews_cubit.dart';
import 'package:online_shopping/Features/reviews/presentation/views/widgets/review_text_field.dart';
import 'package:online_shopping/core/models/user_model.dart';
import 'package:online_shopping/core/utiles/styles.dart';
import 'package:online_shopping/core/widgets/custtom_button.dart';
import 'package:online_shopping/core/widgets/snackbar.dart';

class AddReview extends StatelessWidget {
  AddReview({super.key, required this.product});

  final TextEditingController controller = TextEditingController();
  final Product product;

  @override
  Widget build(BuildContext context) {
    int rating = 0;
    return Scaffold(
      backgroundColor: const Color(0xfff9f9f9),
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          "What is you rate?",
          style: Styles.kSmallTextStyle(context).copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(15),
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
                      onTap: () async {
                        if (controller.text.isNotEmpty) {
                          final ProductReviewModel reviewModel = ProductReviewModel(
                            review: controller.text,
                            dateTime: DateTime.now(),
                            rate: rating,
                            userId: UserModel.getInstance().uid,
                            userName: UserModel.getInstance().name,
                            profilePicture: UserModel.getInstance().profilePicturePath,
                          );
                          await BlocProvider.of<ProductReviewsCubit>(context).createReview(product, reviewModel, product.id);
                          if (context.mounted) {
                            await BlocProvider.of<ProductDetailsCubit>(context).refresh(product.id);
                          }
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
          ],
        ),
      ),
    );
  }
}
