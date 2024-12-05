import 'package:flutter/material.dart';
import 'package:online_shopping/Features/auth/presentation/views/widgets/custtom_button.dart';
import 'package:online_shopping/Features/bag/presentation/views/widgets/my_bag_item.dart';
import 'package:online_shopping/core/utiles/styles.dart';

class BagViewBody extends StatelessWidget {
  const BagViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text("My Bag", style: Styles.kMediumTextStyle(context).copyWith(fontSize: 34)),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return const Column(
                  children: [
                    MyBagItem(),
                    SizedBox(height: 24),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total amount:", style: Styles.kMediumTextStyle(context).copyWith(fontSize: 14, color: Colors.grey)),
              Text("124\$", style: Styles.kSmallTextStyle(context).copyWith(fontSize: 18, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 24),
          CustomButton(height: 50, label: "CHECK OUT", onTap: () {}),
        ],
      ),
    );
  }
}
