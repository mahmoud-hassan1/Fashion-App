import 'package:flutter/material.dart';
import 'package:online_shopping/Features/auth/presentation/views/signup_view/widgets/signup_view_body.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignupViewBody(),
    );
  }
}
