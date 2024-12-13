import 'package:flutter/material.dart';
import 'package:online_shopping/core/widgets/custtom_text_field.dart';

class EmailAndPasswordFields extends StatelessWidget {
  const EmailAndPasswordFields({
    super.key,
    required this.keyForm,
    required this.emailController,
    required this.passwordController,
  });

  final GlobalKey<FormState> keyForm;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          expand: false,
          keyForm: keyForm,
          validator: (value) {
            RegExp regex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
            if (value!.isEmpty) {
              return 'Please enter mail';
            } else {
              if (!regex.hasMatch(value)) {
                return 'Enter valid mail';
              } else {
                return null;
              }
            }
          },
          prefixIcon: const Icon(Icons.mail_outline),
          label: "Email",
          controller: emailController,
        ),
        const SizedBox(
          height: 8,
        ),
        CustomTextField(
          expand: false,
          keyForm: keyForm,
          validator: (value) {
            RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
            if (value!.isEmpty) {
              return 'Please enter password';
            } else {
              if (!regex.hasMatch(value)) {
                return 'Enter valid password';
              } else {
                return null;
              }
            }
          },
          password: true,
          obscure: true,
          prefixIcon: const Icon(Icons.lock_outline),
          label: "Password",
          controller: passwordController,
        ),
      ],
    );
  }
}
