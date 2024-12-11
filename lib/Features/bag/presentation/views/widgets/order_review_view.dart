import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:online_shopping/Features/bag/data/models/order_review_model.dart';
import 'package:online_shopping/Features/bag/data/repo_impl/my_bag_repo_impl.dart';
import 'package:online_shopping/Features/bag/presentation/cubits/order_review_cubit/order_review_cubit.dart';
import 'package:online_shopping/Features/favourite/data/repo_impl/favourite_repo_impl.dart';
import 'package:online_shopping/core/utiles/styles.dart';
import 'package:online_shopping/core/widgets/custtom_button.dart';
import 'package:online_shopping/core/widgets/review_text_field.dart';
import 'package:online_shopping/core/widgets/snackbar.dart';

class OrderReviewView extends StatelessWidget {
  OrderReviewView({super.key});

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int rating = 0;
    return BlocProvider<OrderReviewCubit>(
      create: (context) => OrderReviewCubit(MyBagRepoImpl(FavouriteRepoImpl(firestore: FirebaseFirestore.instance))),
      child: BlocConsumer<OrderReviewCubit, OrderReviewState>(
        listener: (context, state) {
          if (state is OrderReviewFailed) {
            snackBar(content: "Something went wrong!", context: context);
          } else if (state is OrderReviewSuccess) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is OrderReviewLoading,
            child: Scaffold(
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
                                "Please share your opinion\nabout the order",
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
                                  OrderReviewModel review = OrderReviewModel(date: DateTime.now(), review: controller.text, rate: rating);
                                  BlocProvider.of<OrderReviewCubit>(context).addOrderReview(review);
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
            ),
          );
        },
      ),
    );
  }
}
