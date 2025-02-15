import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:online_shopping/Features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:online_shopping/core/utiles/routes.dart';
import 'package:online_shopping/core/widgets/custtom_button.dart';
import 'package:online_shopping/Features/auth/presentation/views/widgets/email_password_section.dart';
import 'package:online_shopping/Features/auth/presentation/views/login_view/widgets/forget_password_section.dart';
import 'package:online_shopping/Features/auth/presentation/views/login_view/widgets/go_to_signup.dart';
import 'package:online_shopping/Features/auth/presentation/views/widgets/google_section.dart';
import 'package:online_shopping/core/utiles/styles.dart';
import 'package:online_shopping/core/widgets/snackbar.dart';

// ignore: must_be_immutable
class LoginViewBody extends StatelessWidget {
  LoginViewBody({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey();
  AutovalidateMode mode = AutovalidateMode.disabled;
  bool isLoading = false;
  bool validate = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          isLoading = true;
          return;
        } else if (state is AuthError) {
          snackBar(content: state.message, context: context);
        } else if (state is AuthAuthenticated) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => AppRouter.navigationBarView),
            (Route<dynamic> route) => false,
          );
        } else if (state is AuthGoToHome) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => AppRouter.navigationBarView),
            (Route<dynamic> route) => false,
          );
        } else if (state is AuthCompleteGoogleAuthProcess) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AppRouter.completeGoogleSignupProcessView(state.oAuthCredential),
            ),
          );
        }
        isLoading = false;
      },
      builder: (context, state) {
        return SafeArea(
          child: ModalProgressHUD(
            inAsyncCall: isLoading,
            child: SingleChildScrollView(
              child: Form(
                key: keyForm,
                autovalidateMode: mode,
                child: Padding(
                  padding: EdgeInsets.only(top: 50.h, left: 16, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Login",
                        style: Styles.kLargeTextStyle(context),
                      ),
                      SizedBox(
                        height: 64.h,
                      ),
                      EmailAndPasswordFields(keyForm: keyForm, emailController: emailController, passwordController: passwordController),
                      const SizedBox(
                        height: 8,
                      ),
                      const ForgetPasswordSection(),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomButton(
                        onTap: () => ontapLogin(context),
                        height: height,
                        label: "LOGIN",
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      GoogleSection(width: width, title: "Or login with:"),
                      const GoToSignup(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void ontapLogin(context) {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty && keyForm.currentState!.validate()) {
      BlocProvider.of<AuthCubit>(context).loginUser(emailController.text, passwordController.text);
    } else {
      snackBar(content: "Please enter Your email and password", context: context);
    }
  }
}
