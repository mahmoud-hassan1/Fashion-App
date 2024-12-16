part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchFailed extends SearchState {
  final String errorMessage;

  SearchFailed(this.errorMessage);
}

final class SearchSuccess extends SearchState {
  final List<Product> products;

  SearchSuccess(this.products);
}
