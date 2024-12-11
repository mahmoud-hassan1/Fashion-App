part of 'order_review_cubit.dart';

@immutable
sealed class OrderReviewState {}

final class OrderReviewInitial extends OrderReviewState {}

final class OrderReviewLoading extends OrderReviewState {}

final class OrderReviewFailed extends OrderReviewState {}

final class OrderReviewSuccess extends OrderReviewState {}
