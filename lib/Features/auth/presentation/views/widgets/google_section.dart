import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:online_shopping/Features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:online_shopping/core/utiles/app_colors.dart';
import 'package:online_shopping/core/utiles/styles.dart';

class GoogleSection extends StatelessWidget {
  const GoogleSection({super.key, required this.width, required this.title});

  final double width;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.center,
            child: Text(
              title,
              style: Styles.kSmallTextStyle(context),
            )),
        const SizedBox(
          height: 8,
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xffE8E8E8), // Lighter shadow color
                  spreadRadius: 0,
                  blurRadius: 1,
                ),
              ],
            ),
            child: IconButton(
              onPressed: () async {
                await BlocProvider.of<AuthCubit>(context).loginWithGoogle();
              },
              style: IconButton.styleFrom(
                backgroundColor: AppColors.kItemBackgroundColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8),
              ),
              icon: SvgPicture.asset(
                "assets/icons/google.svg",
                width: width * 0.14,
              ),
              padding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }
}
