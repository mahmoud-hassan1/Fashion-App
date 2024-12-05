import 'package:flutter/material.dart';
import 'package:online_shopping/Features/bag/presentation/views/widgets/quantity_picker.dart';
import 'package:online_shopping/core/utiles/styles.dart';

class MyBagItem extends StatelessWidget {
  const MyBagItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(height: 100, width: 100, color: Colors.amber),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Pullover", style: Styles.kSmallTextStyle(context)),
                        QuantityPicker(onChanged: (number) {}),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Icon(Icons.more_vert, color: Colors.grey),
                        Text("51\$", style: Styles.kSmallTextStyle(context)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
