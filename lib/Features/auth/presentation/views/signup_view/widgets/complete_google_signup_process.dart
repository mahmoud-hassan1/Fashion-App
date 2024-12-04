import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:online_shopping/Features/auth/data/repo_impl/auth_repo_imp.dart';
import 'package:online_shopping/Features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:online_shopping/Features/auth/presentation/views/signup_view/widgets/date_of_birth.dart';
import 'package:online_shopping/Features/auth/presentation/views/widgets/custtom_button.dart';
import 'package:online_shopping/Features/home/presentation/views/home_view/home_view.dart';
import 'package:online_shopping/core/utiles/styles.dart';
import 'package:online_shopping/core/widgets/custtom_text_field.dart';
import 'package:online_shopping/core/widgets/snackbar.dart';

// ignore: must_be_immutable
class CompleteGoogleSignupProcess extends StatelessWidget {
  CompleteGoogleSignupProcess({super.key, required this.oAuthCredential});

  final TextEditingController nameController = TextEditingController();
  final OAuthCredential oAuthCredential;
  bool isLoading = false;
  final DateTime initDateTime = DateTime(1000);
  DateTime dateTime = DateTime(1000);
  GlobalKey<FormState> keyForm = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final firebaseAuth = FirebaseAuth.instance;
    final authRepository = AuthRepositoryImpl(firebaseAuth: firebaseAuth);
    double height = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => AuthCubit(authRepository),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            isLoading = true;
          } else if (state is AuthError) {
            isLoading = false;
            snackBar(content: state.message, context: context);
          } else if (state is AuthAuthenticated) {
            isLoading = false;
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomeView()),
              (Route<dynamic> route) => false,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
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
                          Text(
                            "Sign up",
                            style: Styles.kLargeTextStyle(context),
                          ),
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
                          DateOfBirth(
                            dateTime: dateTime,
                            onChanged: (date) => dateTime = date,
                          ),
                          const SizedBox(height: 16),
                          CustomButton(
                            onTap: () => ontapSignUp(context),
                            height: height,
                            label: "SIGN UP",
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
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
    if (dateTime.isAtSameMomentAs(initDateTime)) {
      snackBar(content: "Please select date of birth", context: context);
      return;
    }

    if (keyForm.currentState!.validate()) {
      BlocProvider.of<AuthCubit>(context).completeGoogleSignin(dateTime, nameController.text, oAuthCredential);
    } else {
      snackBar(content: "Please enter Your email and password", context: context);
    }
  }
}
