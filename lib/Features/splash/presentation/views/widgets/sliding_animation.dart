import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/constants.dart';

class SlidingAnimation extends StatelessWidget {
  const SlidingAnimation({
    super.key,
    required this.slidingAnimation,
  });

  final Animation<Offset> slidingAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: slidingAnimation,
      builder: (context, snapshot) {
        return SlideTransition(
         position: slidingAnimation,
          child: Text(
           "Easy Shopping",
           style: TextStyle(
             fontSize: 18.sp,
             color: kMainColor,
             fontWeight: FontWeight.bold
           ),
           textAlign: TextAlign.center,
         ),
        );
      }
    );
  }
}
