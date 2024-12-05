import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:online_shopping/core/utiles/styles.dart';

class QuantityPicker extends StatefulWidget {
  const QuantityPicker({super.key, required this.onChanged});

  final void Function(int number) onChanged;

  @override
  State<QuantityPicker> createState() => _QuantityPickerState();
}

class _QuantityPickerState extends State<QuantityPicker> {
  int quan = 1;
  final int maxValue = 10000;
  final int minValue = 1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          getContainer(
            onTap: () {
              quan--;
              quan = quan.clamp(minValue, maxValue);
              widget.onChanged(quan);
              setState(() {});
            },
            icon: Icons.remove,
          ),
          Flexible(
            flex: 2,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: NumberPicker(
                minValue: minValue,
                maxValue: maxValue,
                value: quan,
                itemCount: 1,
                itemWidth: 50,
                textStyle: Styles.kSmallTextStyle(context),
                selectedTextStyle: Styles.kSmallTextStyle(context),
                onChanged: (index) {
                  quan = index;
                  setState(() {});
                },
              ),
            ),
          ),
          getContainer(
            onTap: () {
              quan++;
              quan = quan.clamp(minValue, maxValue);
              widget.onChanged(quan);
              setState(() {});
            },
            icon: Icons.add,
          ),
        ],
      ),
    );
  }

  Widget getContainer({required final void Function() onTap, required IconData icon}) {
    return Flexible(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(.3), blurStyle: BlurStyle.normal, blurRadius: 5, offset: const Offset(0, 3), spreadRadius: 0),
              ],
            ),
            child: Icon(icon, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
