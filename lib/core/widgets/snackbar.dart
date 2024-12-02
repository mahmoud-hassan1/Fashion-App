import 'package:flutter/material.dart';
import 'package:online_shopping/core/utiles/app_colors.dart';
import 'package:online_shopping/core/utiles/styles.dart';

 snackBar({required content,required context,Color? color}){
    ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  content,
                  style: Styles.kSmallTextStyle(context),
                  ),
                backgroundColor: color ?? AppColors.kRed,
              ),
            );
}