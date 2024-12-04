// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_shopping/Features/auth/presentation/views/login_view/login_view.dart';
import 'package:online_shopping/Features/home/presentation/views/navigation_bar_view.dart';
import 'package:online_shopping/Features/splash/presentation/views/widgets/sliding_animation.dart';
import 'package:online_shopping/constants.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
 late Animation<Offset> slidingAnimation;
  @override
  void initState() {
  super.initState();
   initAnimation();
   navigateToLogin();
  }
  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w
            ),
            // child: Image.asset(
            //   kLogo,
            //   width: double.infinity,
            //   fit: BoxFit.cover,
            // )
            child: Container(
            width: double.infinity,
            height: 100.h,
            alignment: Alignment.center,
              child: SvgPicture.asset(
                kLogo,
                fit: BoxFit.cover,
              ),
            ),
            ),
       
         SlidingAnimation(slidingAnimation: slidingAnimation)
      ],
    );
  }
void initAnimation(){
     animationController=AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1)
    );
    slidingAnimation =Tween<Offset>(begin: const Offset(0,4), end: Offset.zero).animate(animationController);
    animationController.forward();
}

  void navigateToLogin() {
     Future.delayed(const Duration(seconds: 2),
    (){
     
     final user = FirebaseAuth.instance.currentUser;
    
     if (user != null) {
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const NavigationBarView(),));
     } else {
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginView(),));
     }
    });
  }
}

