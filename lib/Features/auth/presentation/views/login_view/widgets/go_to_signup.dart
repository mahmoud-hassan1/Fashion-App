import 'package:flutter/material.dart';
import 'package:online_shopping/core/utiles/app_colors.dart';
import 'package:online_shopping/core/utiles/routes.dart';
import 'package:online_shopping/core/utiles/styles.dart';

class GoToSignup extends StatelessWidget {
  const GoToSignup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't Have an account?",
          style: Styles.kSmallTextStyle(context),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AppRouter.signupView,
              ),
            );
          },
          style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
          child: Text("Sign up", style: Styles.kSmallTextStyle(context).copyWith(color: AppColors.kRed)),
        )
      ],
    );
  }
}
