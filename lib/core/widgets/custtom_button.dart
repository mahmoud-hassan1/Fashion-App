import 'package:flutter/material.dart';
import 'package:online_shopping/core/utiles/app_colors.dart';
import 'package:online_shopping/core/utiles/styles.dart';


class CustomButton extends StatelessWidget {
   const CustomButton({
    super.key,
    required this.height, required this.label,   this.onTap,
  });
  final String label;
  final double height;

  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height*.07,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:5 ),
        child: ElevatedButton(
         onPressed: onTap, 
          style: ElevatedButton.styleFrom(
             backgroundColor: AppColors.kRed,
            disabledBackgroundColor:  AppColors.kRed,

             
          ),
           child: Text(label,
            style: Styles.kSmallTextStyle(context).copyWith(
              fontWeight: FontWeight.w500,
             color: Colors.white
             )
          ),
          ),
      ),
    );
  }
}

