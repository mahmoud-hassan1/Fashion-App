class OrderItemModel {
  final String productId;
  final double price;
  final int quantity;

  const OrderItemModel({
    required this.productId,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'price': price,
      'quantity': quantity,
    };
  }

  factory OrderItemModel.fromJson(dynamic json) {
    return OrderItemModel(
      productId: json['productId'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }
}
