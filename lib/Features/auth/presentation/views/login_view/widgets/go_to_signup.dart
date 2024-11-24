import 'package:flutter/material.dart';
import 'package:online_shopping/Features/auth/presentation/views/signup_view/signup_view.dart';
import 'package:online_shopping/core/utiles/app_colors.dart';
import 'package:online_shopping/core/utiles/font.dart';

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
          style: FontStyles.kSmallTextStyle(context),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignupView(),
                ));
          },
          style: TextButton.styleFrom(
              padding: const EdgeInsets.all(0)),
          child: Text("Sign up",
              style: FontStyles.kSmallTextStyle(context)
                  .copyWith(color: AppColors.kRed)),
        )
      ],
    );
  }
}
