import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';

class ColorManager {
  static const Color mainBgDarkColor = Color(0xff393E46);
  static const Color mainBgLightColor = Color(0xffEEEEEE);

  static const Color blueColor1 = Color(0xff0F4C75);
  static const Color blueColor2 = Color(0xff3282B8);
  static const Color blueColor3 = Color(0xffBBE1FA);

  static const Color whiteColor = Color(0xffffffff);
  static const Color lightGreyColor = Color(0xffF0F5F9);
  static const Color darkGreyColor = Color(0xff52616B);

  static const Color caseTypeOut = Color(0xff495579);
  static const Color caseTypeExist = Color(0xff3282B8);
  static const Color caseTypeIn = Color(0xff10A19D);
  static const Color caseTypeDone = Color(0xffADE792);

  static const LinearGradient listViewItemGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    stops: [0.01, 0.8],
    colors: [
      ColorManager.blueColor3,
      ColorManager.blueColor1,
    ],
  );

  static BoxDecoration listViewItemDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: ColorManager.listViewItemGradient);
}
