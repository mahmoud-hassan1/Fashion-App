import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyProfileTextField extends StatefulWidget {
   MyProfileTextField({super.key, this.onTap, this.onChanged, this.controller, required this.label, required this.enabled, this.password=false,this.validator}):obscure=password;
  final bool password;
  final void Function()? onTap;
  final void Function(String value)? onChanged;
  final TextEditingController? controller;
  final String label;
  final bool enabled;
  bool obscure;
  final String? Function(String?)? validator;
  @override
  State<MyProfileTextField> createState() => _MyProfileTextFieldState();
}

class _MyProfileTextFieldState extends State<MyProfileTextField> {
  
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
        onTap: widget.onTap,
        child: TextFormField(
          validator: widget.validator,
          
          onTapOutside: (e) => FocusManager.instance.primaryFocus!.unfocus(), 
          obscureText: widget.obscure,
          maxLines: 1,
          enabled: widget.enabled,
          onChanged: widget.onChanged,
          controller: widget.controller,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
          decoration: InputDecoration(
            hintText: "**********",
            hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
            suffixIcon: widget.password
            ? IconButton(
                onPressed: () {
                  widget.obscure = !widget.obscure;
                  setState(() {});
                },
                icon: Icon(!widget.obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined),
              )
            : null,
            labelText: widget.label,
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
