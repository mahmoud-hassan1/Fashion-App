import 'package:flutter/material.dart';
import 'package:online_shopping/Features/auth/presentation/views/widgets/custtom_button.dart';
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
          ListView.builder(
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return const Column(
                children: [
                  SizedBox(height: 24),
                  MyBagItem(),
                ],
              );
            },
          ),
          CustomButton(height: 50, label: "", onTap: () {}),
        ],
      ),
    );
  }
}

class MyBagItem extends StatelessWidget {
  const MyBagItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(height: 100, width: 100, color: Colors.amber),
        const Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              Column(
                children: [
                  Text("Pullover"),
                ],
              ),
              Column(),
            ],
          ),
        ),
      ],
    );
  }
}
