import 'package:online_shopping/Features/bag/data/models/order_model.dart';
import 'package:online_shopping/Features/profile/data/models/specific_orders_model.dart';

abstract class ProfileRepo {
  Future<void> updateProfileImage();
  Future<void> deleteProfileImage();
  Future<List<OrderModel>> getMyTodayOrders();
  Future<List<SpecificOrderModel>> getMyOrdersOnSpecificDate(DateTime date);
}
