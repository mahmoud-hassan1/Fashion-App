import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:online_shopping/Features/auth/data/repo_impl/auth_repo_imp.dart';
import 'package:online_shopping/Features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:online_shopping/Features/auth/presentation/views/login_view/login_view.dart';
import 'package:online_shopping/Features/auth/presentation/views/signup_view/widgets/complete_google_signup_process.dart';
import 'package:online_shopping/Features/auth/presentation/views/signup_view/widgets/date_text_field.dart';
import 'package:online_shopping/Features/auth/presentation/views/signup_view/widgets/go_to_login.dart';
import 'package:online_shopping/Features/home/presentation/views/navigation_bar_view.dart';
import 'package:online_shopping/core/utiles/di.dart';
import 'package:online_shopping/core/utiles/is_same_day.dart';
import 'package:online_shopping/core/widgets/custtom_button.dart';
import 'package:online_shopping/Features/auth/presentation/views/widgets/email_password_section.dart';
import 'package:online_shopping/Features/auth/presentation/views/widgets/google_section.dart';
import 'package:online_shopping/core/utiles/styles.dart';
import 'package:online_shopping/core/widgets/custtom_text_field.dart';
import 'package:online_shopping/core/widgets/snackbar.dart';

// ignore: must_be_immutable
class SignupViewBody extends StatelessWidget {
  SignupViewBody({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  DateTime dateTime = DateTime.now();
  bool isLoading = false;

  GlobalKey<FormState> keyForm = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(getIt<AuthRepoImpl>()),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            isLoading = true;
            return;
          } else if (state is AuthError) {
            snackBar(content: state.message, context: context);
          } else if (state is AuthAuthenticated) {
            isLoading = false;
            snackBar(color: Colors.green, content: "Verfication link sent to your email", context: context);

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginView(),
              ),
            );
          } else if (state is AuthCompleteGoogleAuthProcess) {
            isLoading = false;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CompleteGoogleSignupProcess(oAuthCredential: state.oAuthCredential),
              ),
            );
          } else if (state is AuthGoToHome) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const NavigationBarView()),
              (Route<dynamic> route) => false,
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
                  child: Padding(
                    padding: EdgeInsets.only(top: 50.h, left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Sign up", style: Styles.kLargeTextStyle(context)),
                        SizedBox(height: 64.h),
                        CustomTextField(
                          controller: nameController,
                          label: "Name",
                          prefixIcon: const Icon(Icons.person_outline_outlined),
                          keyForm: keyForm,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Name';
                            } else {
                              return null;
                            }
                          },
                          expand: false,
                        ),
                        const SizedBox(height: 8),
                        EmailAndPasswordFields(
                          keyForm: keyForm,
                          emailController: emailController,
                          passwordController: passwordController,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        DateTextField(
                          label: 'Date of Birth',
                          dateTime: dateTime,
                          onChanged: (date) {
                            dateTime = date;
                          },
                        ),
                        const GoToLogin(),
                        const SizedBox(height: 16),
                        CustomButton(
                          onTap: () => ontapSignUp(context),
                          height: height,
                          label: "SIGN UP",
                        ),
                        SizedBox(height: 32.h),
                        GoogleSection(title: "Or sign up with:", width: width),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void ontapSignUp(context) {
    debugPrint("sssssssssssssssssss");
    if (isSameDay(dateTime, DateTime.now())) {
      snackBar(content: "Please select date of birth", context: context);
      return;
    }

    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty && keyForm.currentState!.validate()) {
      BlocProvider.of<AuthCubit>(context).signupUser(nameController.text, emailController.text, dateTime, passwordController.text);
    } else {
      snackBar(content: "Please enter Your email and password", context: context);
    }
  }
}
