import 'package:online_shopping/Features/bag/data/models/order_model.dart';
import 'package:online_shopping/Features/profile/data/models/products_statistics_model.dart';
import 'package:online_shopping/Features/profile/data/models/specific_orders_model.dart';

abstract class ProfileRepo {
  Future<void> updateProfileImage();
  Future<void> deleteProfileImage();
  Future<List<OrderModel>> getMyTodayOrders(DateTime date);
  Future<List<SpecificOrderModel>> getMyOrdersOnSpecificDate(DateTime date);
  Future<void> saveUserChanges(String name, DateTime dateOfBirth);
  Future<void> savePassword(String newPassword);
  Future<List<ProductStatisticsModel>> getProductsBestSelling();
}
