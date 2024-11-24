import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Ensure this import is included
import 'package:online_shopping/Features/auth/presentation/views/login_view/widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    // Set the status bar to be transparent
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
    ));
    
    return Scaffold(
      body: LoginViewBody(),
    );
  }
}