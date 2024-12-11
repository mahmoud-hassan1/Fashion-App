import 'package:flutter/material.dart';
import 'package:online_shopping/core/utiles/styles.dart';

class ReviewTextField extends StatelessWidget {
  const ReviewTextField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: Colors.grey,
      minLines: 10,
      maxLines: 10,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        border: outlineInputBorder(2),
        enabledBorder: outlineInputBorder(1.5),
        focusedBorder: outlineInputBorder(2),
        hintText: "Your review",
        hintStyle: Styles.kFontSize14(context).copyWith(color: Colors.grey),
      ),
    );
  }

  OutlineInputBorder outlineInputBorder(double width) {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(width: 0, color: Colors.transparent),
    );
  }
}
