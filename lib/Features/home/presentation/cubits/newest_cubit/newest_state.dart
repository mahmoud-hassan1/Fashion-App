part of 'newest_cubit.dart';

@immutable
sealed class NewestState {}

final class NewestInitial extends NewestState {}
final class NewestLoading extends NewestState {}
final class NewestSuccess extends NewestState {
  final List<Product> products;
  NewestSuccess({required this.products});
}
final class NewestFail extends NewestState {
  final String message;
  NewestFail({required this.message});
}
