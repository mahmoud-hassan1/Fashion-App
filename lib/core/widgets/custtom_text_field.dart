import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/core/utiles/app_colors.dart';
import 'package:online_shopping/core/utiles/styles.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
    required this.prefixIcon,
    this.obscure = false,
    this.keyForm,
    this.validate = false,
    this.expand = true,
    this.enabled = true,
    this.password = false,
  });

  final bool expand;
  final Icon prefixIcon;
  bool validate;
  final String label;
  final bool password;
  bool obscure;
  final TextEditingController controller;
  GlobalKey<FormState>? keyForm;
  final String? Function(String?)? validator;
  final bool enabled;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();
  final Color _fillColor = AppColors.kItemBackgroundColor;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        if (widget.keyForm != null) {
          widget.validate = true;
          widget.keyForm!.currentState!.validate();
        }
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 1,
      maxLines: widget.expand ? null : 1,
      controller: widget.controller,
      focusNode: _focusNode,
      obscureText: widget.obscure,
      enabled: widget.enabled,
      decoration: InputDecoration(
        suffixIcon: widget.password
            ? IconButton(
                onPressed: () {
                  widget.obscure = !widget.obscure;
                  setState(() {});
                },
                icon: Icon(!widget.obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined),
              )
            : null,
        prefixIcon: widget.prefixIcon,
        label: Text(
          widget.label,
          style: Styles.kSmallTextStyle(context).copyWith(color: Colors.grey),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
        focusedErrorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.redAccent)),
        errorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.redAccent)),
        errorStyle: const TextStyle(color: Colors.redAccent),
        filled: true,
        fillColor: _fillColor,
        contentPadding: EdgeInsets.symmetric(vertical: 14.h),
      ),
      validator: widget.validate ? widget.validator : null,
    );
  }
}
