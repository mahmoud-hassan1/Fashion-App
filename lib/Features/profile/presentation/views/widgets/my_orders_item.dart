import 'package:flutter/material.dart';
import 'package:online_shopping/Features/bag/data/models/order_item_model.dart';
import 'package:online_shopping/Features/bag/data/models/order_model.dart';
import 'package:online_shopping/Features/reviews/data/models/review_model.dart';
import 'package:online_shopping/Features/reviews/presentation/views/widgets/review_item.dart';
import 'package:online_shopping/core/models/user_model.dart';
import 'package:online_shopping/core/utiles/get_date.dart';
import 'package:online_shopping/core/utiles/styles.dart';

class MyOrdersItem extends StatelessWidget {
  const MyOrdersItem({super.key, required this.index, required this.order, required this.review});

  final int index;
  final OrderModel order;
  final ReviewModel? review;

  @override
  Widget build(BuildContext context) {
    int quan = 0;
    for (OrderItemModel item in order.items) {
      quan += item.quantity;
    }

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order No: ${UserModel.getInstance().uid.substring(UserModel.getInstance().uid.length - 5)}$index ",
                style: Styles.kFontSize14(context).copyWith(fontSize: 16, color: Colors.black),
              ),
              Text(
                getDate(order.date),
                style: Styles.kFontSize14(context).copyWith(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Quantity $quan",
                style: Styles.kFontSize14(context).copyWith(fontSize: 12),
              ),
              Text(
                "Total Price: ${order.totalPrice.toStringAsFixed(2)}\$",
                style: Styles.kFontSize14(context).copyWith(fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 15),
          if (review != null)
            Text(
              "Reviews",
              style: Styles.kFontSize17(context),
            )
          else
            Text(
              "No reviews",
              style: Styles.kFontSize17(context),
            ),
          const SizedBox(height: 10),
          if (review != null) ReviewItem(reviewModel: review!),
        ],
      ),
    );
  }
}
