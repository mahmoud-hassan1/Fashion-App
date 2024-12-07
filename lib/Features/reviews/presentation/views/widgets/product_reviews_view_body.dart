import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/product/presentation/cubits/product_details_cubit/product_details_cubit.dart';
import 'package:online_shopping/Features/reviews/presentation/cubits/product_reviews_cubit/product_reviews_cubit.dart';
import 'package:online_shopping/Features/reviews/presentation/views/widgets/rating_statistics.dart';
import 'package:online_shopping/Features/reviews/presentation/views/widgets/review_item.dart';
import 'package:online_shopping/core/utiles/styles.dart';
import 'package:online_shopping/core/widgets/snackbar.dart';

// ignore: must_be_immutable
class ProductReviewsViewBody extends StatelessWidget {
  ProductReviewsViewBody({super.key, required this.product});

  Product product;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductReviewsCubit, ProductReviewsState>(
      listener: (context, state) {
        if (state is ProductReviewsSuccess) {
          Navigator.pop(context);
        } else if (state is ProductReviewsFailed) {
          snackBar(content: state.errorMessage, context: context);
        }
      },
      builder: (context, state) {
        return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            if (state is ProductDetailsRefresh) {
              product = state.product;
            }
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
          },
        );
      },
    );
  }
}
