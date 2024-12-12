import 'package:flutter/material.dart';
class SubmitEditsButton extends StatelessWidget {
final VoidCallback? onPressed;
final String title;
  const SubmitEditsButton({
    super.key,
     required this.onPressed,
     required this.title,

  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child:  Text(
        title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
