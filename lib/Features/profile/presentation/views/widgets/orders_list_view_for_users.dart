import 'package:flutter/material.dart';
import 'package:online_shopping/Features/bag/data/models/order_model.dart';
import 'package:online_shopping/Features/profile/presentation/views/widgets/my_orders_item.dart';
import 'package:online_shopping/Features/reviews/data/models/review_model.dart';
import 'package:online_shopping/core/models/user_model.dart';

class OrdersListViewForUsers extends StatelessWidget {
  const OrdersListViewForUsers({super.key, required this.orders});

  final List<OrderModel> orders;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 10,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: orders.length,
        itemBuilder: (BuildContext context, int index) {
          ReviewModel? review;
          if (orders[index].orderReview != null) {
            review = ReviewModel(
              review: orders[index].orderReview!.review,
              dateTime: orders[index].orderReview!.date,
              rate: orders[index].orderReview!.rate,
              userName: UserModel.getInstance().name,
              profilePicture: UserModel.getInstance().profilePicturePath,
              userId: UserModel.getInstance().uid,
            );
          }

          return Column(
            children: [
              MyOrdersItem(order: orders[index], index: index, review: review),
              const SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }
}
