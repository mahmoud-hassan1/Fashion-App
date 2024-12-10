import 'package:online_shopping/Features/bag/data/models/order_item_model.dart';

class OrderModel {
  final List<OrderItemModel> items;
  late double _totalPrice;

  get totalPrice => _totalPrice;

  OrderModel({required this.items}) {
    _totalPrice = 0;
    for (OrderItemModel item in items) {
      _totalPrice += (item.price * item.quantity);
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'items': items.map((OrderItemModel item) => item.toMap()).toList(),
      'review': {},
    };
  }

  factory OrderModel.fromJson(dynamic json) {
    return OrderModel(
      items: json['items'].map((item) => OrderItemModel.fromJson(item)).toList(),
    );
  }
}
