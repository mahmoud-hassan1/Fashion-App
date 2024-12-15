// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/Features/auth/presentation/views/login_view/login_view.dart';
import 'package:online_shopping/Features/home/presentation/views/navigation_bar_view.dart';
import 'package:online_shopping/Features/splash/presentation/cubits/cubit/user_cubit.dart';
import 'package:online_shopping/core/utiles/app_colors.dart';
import 'package:online_shopping/core/utiles/styles.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> positionAnimationFashionApp;
  late Animation<Offset> positionAnimationEasyShopping;
  late Animation<Color?> colorAnimationFashionApp;

  @override
  void initState() {
    super.initState();
    initAnimation();
    navigateToLogin();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserSuccess) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const NavigationBarView(),
              ));
        } else if (state is UserFail) {
          BlocProvider.of<UserCubit>(context).getUserData();
        }
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return SlideTransition(
                  position: positionAnimationFashionApp,
                  child: Text(
                    "Fashion App",
                    style: Styles.kFontSize60(context).copyWith(color: colorAnimationFashionApp.value,)
                  ),
                );
              },
            ),
            SizedBox(height: 20.h), 
            AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return SlideTransition(
                  position: positionAnimationEasyShopping,
                  child: Text(
                    "Easy Shopping",
                    style: Styles.kFontSize30(context).copyWith(color: colorAnimationFashionApp.value,)
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void initAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

   
    positionAnimationFashionApp = Tween<Offset>(
      begin: const Offset(-2, 0), 
      end: Offset.zero, 
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    ));

    positionAnimationEasyShopping = Tween<Offset>(
      begin: const Offset(0, 2), 
      end: Offset.zero, 
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    ));


    colorAnimationFashionApp = ColorTween(
        begin: AppColors.kSeconderyTextColor,
      end: AppColors.kRed,
    ).animate(animationController);

    animationController.forward();
  }

  void navigateToLogin() {
    Future.delayed(const Duration(seconds: 3), () {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        BlocProvider.of<UserCubit>(context).getUserData();
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginView(),
            ));
      }
    });
  }
}
