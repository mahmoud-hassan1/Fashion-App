import 'package:flutter/material.dart';
import 'package:online_shopping/Features/auth/presentation/views/reset_password_view/reset_password_view.dart';
import 'package:online_shopping/core/utiles/app_colors.dart';
import 'package:online_shopping/core/utiles/styles.dart';

class ForgetPasswordSection extends StatelessWidget {
  const ForgetPasswordSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "Forget your password?",
          style: Styles.kSmallTextStyle(context),
        ),
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const ResetPasswordView(),
                  ));
            },
            icon: const Icon(
              Icons.arrow_right_alt_sharp,
              color: AppColors.kRed,
            ))
      ],
    );
  }
}

