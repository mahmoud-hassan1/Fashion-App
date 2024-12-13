import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/Features/auth/presentation/views/signup_view/widgets/date_text_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:online_shopping/Features/profile/presentation/cubits/my_orders_cubit/my_orders_cubit.dart';
import 'package:online_shopping/Features/profile/presentation/views/widgets/orders_list_view_for_admins.dart';
import 'package:online_shopping/Features/profile/presentation/views/widgets/orders_list_view_for_users.dart';
import 'package:online_shopping/core/models/user_model.dart';
import 'package:online_shopping/core/utiles/styles.dart';
import 'package:online_shopping/core/widgets/snackbar.dart';

// ignore: must_be_immutable
class MyOrdersView extends StatelessWidget {
  MyOrdersView({super.key});

  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (UserModel.getInstance().role == Role.user) {
        await BlocProvider.of<MyOrdersCubit>(context).getMyOrders(date);
      } else if (UserModel.getInstance().role == Role.admin) {
        await BlocProvider.of<MyOrdersCubit>(context).getMyOrdersOnSpecificDate(date);
      }
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
                      label: "Date",
                      dateTime: date,
                      onChanged: (dateTime) async {
                        date = dateTime;
                        if (UserModel.getInstance().role == Role.user) {
                          await BlocProvider.of<MyOrdersCubit>(context).getMyOrders(date);
                        } else if (UserModel.getInstance().role == Role.admin) {
                          await BlocProvider.of<MyOrdersCubit>(context).getMyOrdersOnSpecificDate(date);
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    <Widget>() {
                      if (state is MyOrdersUserSuccess) {
                        return OrdersListViewForUsers(orders: state.orders);
                      } else if (state is MyOrdersAdminSuccess) {
                        return OrdersListViewForAdmins(orders: state.orders);
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
