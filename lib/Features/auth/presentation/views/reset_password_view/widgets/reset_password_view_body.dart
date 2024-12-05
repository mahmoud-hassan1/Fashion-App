import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:online_shopping/Features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:online_shopping/core/widgets/custtom_button.dart';
import 'package:online_shopping/core/utiles/styles.dart';
import 'package:online_shopping/core/widgets/custtom_text_field.dart';
import 'package:online_shopping/core/widgets/snackbar.dart';

// ignore: must_be_immutable
class ResetPasswordViewBody extends StatelessWidget {
  ResetPasswordViewBody({super.key});
  GlobalKey<FormState> keyForm = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          snackBar(
              content: "Reset password link sent to your email",
              context: context);
          Navigator.pop(context);
          isLoading = false;
        } else if (state is AuthLoading) {
          isLoading = true;
        } else if (state is AuthError) {
          snackBar(content: state.message, context: context);
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            body: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Form(
                        key: keyForm,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Enter Email to send password reset link to",
                              style: Styles.kMediumTextStyle(context),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            CustomTextField(
                              expand: false,
                              keyForm: keyForm,
                              validator: (value) {
                                RegExp regex = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
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
                              height: 32,
                            ),
                            CustomButton(
                              onTap: () {
                                if (emailController.text.isNotEmpty &&
                                    keyForm.currentState!.validate()) {
                                  BlocProvider.of<AuthCubit>(context)
                                      .resetPassword(emailController.text);
                                } else {
                                  snackBar(
                                      content: "Please enter Your email",
                                      context: context);
                                }
                              },
                              height: height,
                              label: "Send Email",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
