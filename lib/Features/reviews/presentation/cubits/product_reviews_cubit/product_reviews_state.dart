part of 'product_reviews_cubit.dart';

@immutable
sealed class ProductReviewsState {}

final class ProductReviewsInitial extends ProductReviewsState {}

final class ProductReviewsLoading extends ProductReviewsState {}

final class ProductReviewsSuccess extends ProductReviewsState {}

final class ProductReviewsRefresh extends ProductReviewsState {
  final List<ProductReviewModel> reviews;

  ProductReviewsRefresh({required this.reviews});
}

final class ProductReviewsFailed extends ProductReviewsState {
  final String errorMessage;

  ProductReviewsFailed(this.errorMessage);
}
