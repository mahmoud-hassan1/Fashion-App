import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:online_shopping/Features/auth/presentation/views/widgets/custtom_button.dart';
import 'package:online_shopping/Features/bag/presentation/cubits/bag_cubit/bag_cubit.dart';
import 'package:online_shopping/Features/bag/presentation/views/widgets/bag_item.dart';
import 'package:online_shopping/Features/bag/presentation/views/widgets/order_review_view.dart';
import 'package:online_shopping/core/utiles/assets.dart';
import 'package:online_shopping/core/utiles/styles.dart';
import 'package:online_shopping/core/widgets/scale_down.dart';
import 'package:online_shopping/core/widgets/snackbar.dart';

class BagViewBody extends StatelessWidget {
  const BagViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await BlocProvider.of<MyBagCubit>(context).getMyProducts();
    });

    return BlocConsumer<MyBagCubit, MyBagState>(
      listener: (context, state) {
        if (state is MyBagSuccessed) {
          state.message != null ? snackBar(content: state.message, context: context) : null;
        } else if (state is MyBagFailed) {
          snackBar(content: "Something went wrong", context: context);
        } else if (state is MyBagGoToOrderReview) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => OrderReviewView()),
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is MyBagLoading,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                ScaleDown(child: Text("My Bag", style: Styles.kMediumTextStyle(context).copyWith(fontSize: 34))),
                const SizedBox(height: 24),
                if (state is MyBagFailed)
                  error(context)
                else if ((state is MyBagSuccessed && state.items.isEmpty) || state is MyBagGoToOrderReview)
                  noThingToShow(context)
                else if (state is MyBagSuccessed && state.items.isNotEmpty)
                  Expanded(
                    flex: 6,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 5,
                          child: ListView.builder(
                            itemCount: state.items.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  MyBagItem(myBagItemModel: state.items[index]),
                                  const SizedBox(height: 12),
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ScaleDown(
                                  child: Text("Total amount:", style: Styles.kMediumTextStyle(context).copyWith(fontSize: 14, color: Colors.grey)),
                                ),
                                const SizedBox(width: 10),
                                ScaleDown(
                                  child: Text(
                                    "${BlocProvider.of<MyBagCubit>(context).calculateTotalPrice()}\$",
                                    style: Styles.kSmallTextStyle(context).copyWith(fontSize: 18, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            CustomButton(
                              height: 600,
                              label: "CHECK OUT",
                              onTap: () async {
                                await BlocProvider.of<MyBagCubit>(context).checkOut();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget noThingToShow(BuildContext context) {
    return Column(
      children: [
        Center(child: Lottie.asset(Assets.animationsEmptyAnimation)),
        Text(
          "No Products Added Yet",
          style: Styles.kFontSize30(context),
        )
      ],
    );
  }

  Widget error(BuildContext context) {
    return Center(
      child: Text(
        "Something went wrong!",
        style: Styles.kFontSize30(context),
      ),
    );
  }
}
