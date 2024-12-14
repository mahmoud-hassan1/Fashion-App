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
      itemsKey: items.map((OrderItemModel item) => item.toMap()).toList(),
      dateKey: date.toIso8601String(),
      reviewKey: orderReview != null ? orderReview?.toMap() : {},
    };
  }

  static String itemsKey = 'items';
  static String dateKey = 'date';
  static String reviewKey = 'review';
  static String ordersKey = 'orders';

  factory OrderModel.fromJson(dynamic json) {
    return OrderModel(
      items: json[itemsKey].map<OrderItemModel>((item) => OrderItemModel.fromJson(item)).toList(),
      date: DateTime.parse(json[dateKey]),
      orderReview: json[reviewKey].isEmpty ? null : OrderReviewModel.fromJson(json[reviewKey]),
    );
  }
}
