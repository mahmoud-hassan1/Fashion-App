import 'package:online_shopping/Features/bag/data/models/my_bag_item_model.dart';
import 'package:online_shopping/Features/bag/data/models/order_item_model.dart';

class OrderMapper {
  static OrderItemModel toOrderItemModel(MyBagItemModel myBagItemModel) {
    return OrderItemModel(
      productId: myBagItemModel.product.id,
      price: myBagItemModel.product.price,
      quantity: myBagItemModel.quan,
    );
  }
}
