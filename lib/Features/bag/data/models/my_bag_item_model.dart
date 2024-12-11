import 'package:online_shopping/Features/home/data/models/product_model.dart';

class MyBagItemModel {
  final ProductModel product;
  int quan;

  MyBagItemModel({required this.product, this.quan = 1});
}
