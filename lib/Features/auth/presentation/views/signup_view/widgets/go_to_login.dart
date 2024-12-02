import 'package:flutter/material.dart';
import 'package:online_shopping/Features/auth/presentation/views/login_view/login_view.dart';
import 'package:online_shopping/core/utiles/app_colors.dart';
import 'package:online_shopping/core/utiles/styles.dart';

class GoToLogin extends StatelessWidget {
  const GoToLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "Already have an account?",
          style: Styles.kSmallTextStyle(context),
        ),
        IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginView(),
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
