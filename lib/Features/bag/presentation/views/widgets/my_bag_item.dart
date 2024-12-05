import 'package:flutter/material.dart';
import 'package:online_shopping/Features/bag/presentation/views/widgets/quantity_picker.dart';
import 'package:online_shopping/core/utiles/assets.dart';
import 'package:online_shopping/core/utiles/styles.dart';
import 'package:online_shopping/core/widgets/scale_down.dart';

class MyBagItem extends StatelessWidget {
  const MyBagItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).width * .3,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(.3), blurStyle: BlurStyle.normal, blurRadius: 5, offset: const Offset(0, 3), spreadRadius: 0),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Image.asset(Assets.imagesClothes),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text("Pullover", style: Styles.kSmallTextStyle(context)),
                  ),
                  QuantityPicker(onChanged: (number) {}),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ScaleDown(
                    child: GestureDetector(
                      onTap: () {},
                      child: const Icon(Icons.more_vert, color: Colors.grey),
                    ),
                  ),
                  ScaleDown(
                    child: Text("51\$", style: Styles.kSmallTextStyle(context)),
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
