part of 'products_statistics_cubit.dart';

@immutable
sealed class ProductsStatisticsState {}

final class ProductsStatisticsInitial extends ProductsStatisticsState {}

final class ProductsStatisticsLoading extends ProductsStatisticsState {}

final class ProductsStatisticsSuccess extends ProductsStatisticsState {
  final List<ProductStatisticsModel> productStatistics;

  ProductsStatisticsSuccess(this.productStatistics);
}

final class ProductsStatisticsFailed extends ProductsStatisticsState {}
