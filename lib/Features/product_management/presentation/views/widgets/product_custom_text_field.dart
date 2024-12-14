import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final Icon prefixIcon;
  final bool expand;
  final bool validate;
  final String? Function(String?)? validator;
  final bool isNumber;
  final bool isDecimal;
  final bool enabled;
  final Function(String)? onChange;
  const ProductCustomTextField(
      {super.key,
      required this.label,
      required this.controller,
      required this.prefixIcon,
      this.expand = false,
      this.validate = false,
      this.validator,
      this.isNumber = false,
      this.isDecimal = false,
      this.enabled = true,
      this.onChange});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      minLines: 1,
      maxLines: expand ? 4 : 1,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      keyboardType: isNumber ? (isDecimal ? const TextInputType.numberWithOptions(decimal: true) : TextInputType.number) : TextInputType.text,
      inputFormatters: isNumber
          ? [
              if (isDecimal) FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')) else FilteringTextInputFormatter.digitsOnly,
            ]
          : null,
      validator: validate ? validator : null,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: onChange,
    );
  }
}
