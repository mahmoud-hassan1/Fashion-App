import 'package:flutter/material.dart';
abstract class FontStyles{
 static  TextStyle kLargeTextStyle (BuildContext context)=>TextStyle(
  fontFamily: "metro",
  fontWeight: FontWeight.w700,
  color: Colors.black,
  fontSize: getResponsiveFontSize(context,fontSize: 45),
 ) ;
  static  TextStyle kMediumTextStyle(BuildContext context)=>TextStyle(
  fontFamily: "metro",
  color: Colors.black,
  fontWeight: FontWeight.w600,
  fontSize: getResponsiveFontSize(context,fontSize: 24),
 ) ;
  static TextStyle kSmallTextStyle (BuildContext context)=>TextStyle(
  fontFamily: "metro",
  color: Colors.black,
  fontWeight: FontWeight.w500,
  fontSize: getResponsiveFontSize(context,fontSize: 20),
 ) ;
  static TextStyle kFontSize30 (BuildContext context)=>TextStyle(
  fontFamily: "metro",
  color: Colors.black,
  fontWeight: FontWeight.w700,
  fontSize: getResponsiveFontSize(context,fontSize: 30),
 ) ;
  static TextStyle kFontSize60 (BuildContext context)=>TextStyle(
   fontFamily: "metro",
  color: Colors.white,
  fontWeight: FontWeight.w900,
  fontSize: getResponsiveFontSize(context,fontSize: 60),
 ) ;
 
}
double getResponsiveFontSize(context,{required double fontSize}) {
  double scaleFactor = getScaleFactor(context);
  double responsiveFontSize = fontSize * scaleFactor;

  double lowerLimit = fontSize * 0.8;
  double upperLimit = fontSize * 1.2;

  return responsiveFontSize.clamp(lowerLimit, upperLimit);
}double getScaleFactor(context) {

  double width = MediaQuery.sizeOf(context).width;
  if (width > 800) {

    return width /700;
  } else if (width > 500) {
    return width / 450;
  } else {
    return width /500 ;
  }
}