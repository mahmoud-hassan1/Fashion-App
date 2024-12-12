import 'package:online_shopping/Features/bag/data/models/order_item_model.dart';
import 'package:online_shopping/Features/bag/data/models/order_review_model.dart';

class OrderModel {
  final List<OrderItemModel> items;
  final DateTime date;
  final OrderReviewModel? orderReview;

  late double _totalPrice;

  double get totalPrice => _totalPrice;

  OrderModel({required this.items, required this.date, this.orderReview}) {
    _totalPrice = 0;
    for (OrderItemModel item in items) {
      _totalPrice += (item.price * item.quantity);
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'items': items.map((OrderItemModel item) => item.toMap()).toList(),
      'date': date.toIso8601String(),
      'review': orderReview != null ? orderReview?.toMap() : {},
    };
  }

  factory OrderModel.fromJson(dynamic json) {
    return OrderModel(
      items: json['items'].map<OrderItemModel>((item) => OrderItemModel.fromJson(item)).toList(),
      date: DateTime.parse(json['date']),
      orderReview: json['review'].isEmpty ? null : OrderReviewModel.fromJson(json['review']),
    );
  }
}
