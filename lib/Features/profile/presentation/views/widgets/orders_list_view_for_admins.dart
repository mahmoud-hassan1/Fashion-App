import 'package:flutter/material.dart';
import 'package:online_shopping/Features/profile/data/models/specific_orders_model.dart';
import 'package:online_shopping/Features/profile/presentation/views/widgets/my_orders_item.dart';
import 'package:online_shopping/Features/reviews/data/models/review_model.dart';

class OrdersListViewForAdmins extends StatelessWidget {
  const OrdersListViewForAdmins({super.key, required this.orders});

  final List<SpecificOrderModel> orders;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 10,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: orders.length,
        itemBuilder: (BuildContext context, int index) {
          ReviewModel? review;
          if (orders[index].orderModel.orderReview != null) {
            review = ReviewModel(
              review: orders[index].orderModel.orderReview!.review,
              dateTime: orders[index].orderModel.orderReview!.date,
              rate: orders[index].orderModel.orderReview!.rate,
              userName: orders[index].name,
              profilePicture: orders[index].profilePicturePath,
              userId: orders[index].uid,
            );
          }

          return Column(
            children: [
              MyOrdersItem(order: orders[index].orderModel, index: index, review: review),
              const SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }
}
