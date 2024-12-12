import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/Features/profile/presentation/views/widgets/date_text_field.dart';
import 'package:online_shopping/Features/profile/presentation/views/widgets/my_orders_item.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:online_shopping/Features/profile/presentation/cubits/my_orders_cubit/my_orders_cubit.dart';
import 'package:online_shopping/Features/reviews/data/models/product_review_model.dart';
import 'package:online_shopping/core/utiles/styles.dart';
import 'package:online_shopping/core/widgets/snackbar.dart';

// ignore: must_be_immutable
class MyOrdersView extends StatelessWidget {
  MyOrdersView({super.key});

  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await BlocProvider.of<MyOrdersCubit>(context).getMyOrders(date);
    });

    return BlocConsumer<MyOrdersCubit, MyOrdersState>(
      listener: (context, state) {
        if (state is MyOrdersFailed) {
          snackBar(content: "Something went wrong!", context: context);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is MyOrdersLoading,
          child: Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("My Orders", style: Styles.kMediumTextStyle(context).copyWith(fontSize: 34)),
                    const SizedBox(height: 10),
                    DateTextField(
                      initialDate: date,
                      onDateChanged: (dateTime) async {
                        date = dateTime;
                        await BlocProvider.of<MyOrdersCubit>(context).getMyOrders(date);
                      },
                    ),
                    const SizedBox(height: 10),
                    <Widget>() {
                      if (state is MyOrdersSuccess) {
                        return Expanded(
                          flex: 10,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.orders.length,
                            itemBuilder: (BuildContext context, int index) {
                              ReviewModel? review;
                              if (state.orders[index].orderModel.orderReview != null) {
                                review = ReviewModel(
                                  review: state.orders[index].orderModel.orderReview!.review,
                                  dateTime: state.orders[index].orderModel.orderReview!.date,
                                  rate: state.orders[index].orderModel.orderReview!.rate,
                                  userName: state.orders[index].name,
                                  profilePicture: state.orders[index].profilePicturePath,
                                  userId: state.orders[index].uid,
                                );
                              }

                              return Column(
                                children: [
                                  MyOrdersItem(order: state.orders[index].orderModel, index: index, review: review),
                                  const SizedBox(height: 10),
                                ],
                              );
                            },
                          ),
                        );
                      } else if (state is MyOrdersLoading) {
                        return const Column();
                      } else {
                        return const Text("No orders found.");
                      }
                    }.call(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
