import 'package:flutter/material.dart';
import 'package:online_shopping/core/utiles/app_colors.dart';
import 'package:online_shopping/core/utiles/font.dart';

 snackBar({required content,required context,Color? color}){
    ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  content,
                  style: FontStyles.kSmallTextStyle(context),
                  ),
                backgroundColor: color ?? AppColors.kRed,
              ),
            );
}