import 'package:flutter/material.dart';
import 'package:online_shopping/core/utiles/styles.dart';
import 'package:online_shopping/core/widgets/scale_down.dart';

class QuantityPicker extends StatefulWidget {
  const QuantityPicker({super.key, required this.onChanged});

  final void Function(int number) onChanged;

  @override
  State<QuantityPicker> createState() => _QuantityPickerState();
}

class _QuantityPickerState extends State<QuantityPicker> {
  int quan = 1;
  final int maxValue = 9999;
  final int minValue = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
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
        const SizedBox(width: 5),
        ScaleDown(
          flex: 2,
          child: SizedBox(
            width: 45,
            child: Center(child: Text(quan.toString(), style: Styles.kSmallTextStyle(context))),
          ),
        ),
        const SizedBox(width: 5),
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
    );
  }

  Widget getContainer({required final void Function() onTap, required IconData icon}) {
    return ScaleDown(
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
          child: Icon(icon, color: Colors.grey, size: 24),
        ),
      ),
    );
  }
}
