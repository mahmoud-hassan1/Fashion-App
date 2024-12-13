import 'package:flutter/material.dart';

class MyProfileTextField extends StatelessWidget {
  const MyProfileTextField({super.key, this.onTap, this.onChanged, this.controller, required this.label, required this.enabled});

  final void Function()? onTap;
  final void Function(String value)? onChanged;
  final TextEditingController? controller;
  final String label;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurStyle: BlurStyle.outer,
            blurRadius: 1,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: onTap,
        child: TextField(
          onTapOutside: (e) => FocusManager.instance.primaryFocus!.unfocus(),
          maxLines: 1,
          enabled: enabled,
          onChanged: onChanged,
          controller: controller,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Colors.white,
            disabledBorder: const OutlineInputBorder(borderSide: BorderSide(width: 0, color: Colors.white)),
            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(width: 0, color: Colors.white)),
            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(width: 0, color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
