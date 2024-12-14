class OrderItemModel {
  final String productId;
  final double price;
  final int quantity;

  const OrderItemModel({
    required this.productId,
    required this.price,
    required this.quantity,
  });

  static String productIdKey = 'productId';
  static String priceKey = 'price';
  static String quantityKey = 'quantity';

  Map<String, dynamic> toMap() {
    return {
      productIdKey: productId,
      priceKey: price,
      quantityKey: quantity,
    };
  }

  factory OrderItemModel.fromJson(dynamic json) {
    return OrderItemModel(
      productId: json[productIdKey],
      price: json[priceKey].toDouble(),
      quantity: json[quantityKey],
    );
  }
}
