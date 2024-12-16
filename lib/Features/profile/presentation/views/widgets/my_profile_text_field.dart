import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyProfileTextField extends StatefulWidget {
   const MyProfileTextField({super.key, this.onTap, this.onChanged, this.controller, required this.label, required this.enabled, this.password=false,this.validator});
  final bool password;
  final void Function()? onTap;
  final void Function(String value)? onChanged;
  final TextEditingController? controller;
  final String label;
  final bool enabled;
  
  final String? Function(String?)? validator;
  @override
  State<MyProfileTextField> createState() => _MyProfileTextFieldState();
}

class _MyProfileTextFieldState extends State<MyProfileTextField> {
 late bool obscure;
  @override
  void initState() {
    obscure=widget.password;
    super.initState();
  }
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
          obscureText: obscure,
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
                  obscure = !obscure;
                  setState(() {});
                },
                icon: Icon(!obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined),
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
