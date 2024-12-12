import 'package:online_shopping/Features/bag/data/models/order_model.dart';

class SpecificOrderModel {
  final OrderModel orderModel;
  final String name;
  final String email;
  final String uid;
  final String profilePicturePath;

  const SpecificOrderModel({
    required this.orderModel,
    required this.name,
    required this.email,
    required this.uid,
    required this.profilePicturePath,
  });

  factory SpecificOrderModel.fromJson(dynamic userJson, dynamic orderJson) {
    return SpecificOrderModel(
      orderModel: OrderModel.fromJson(orderJson),
      name: userJson['name'],
      email: userJson['email'],
      uid: userJson['uid'],
      profilePicturePath: userJson['profilePicturePath'],
    );
  }
}
