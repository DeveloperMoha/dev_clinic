import 'package:flutter/material.dart';

import '../utils/color_manager.dart';
import '../utils/font_manager.dart';
import '../utils/images_manager.dart';

Widget addingTitleText(String title,
    {double textSize = 20.0,
    titleColor = ColorManager.darkGreyColor,
    fontfamily = FontManager.signikaNegativeLight}) {
  return Text(
    title,
    style: TextStyle(
      fontSize: textSize,
      fontFamily: fontfamily,
      color: titleColor,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget addingSharedTextFormField(
    TextInputType textInputType, fieldController, width,
    {bool enable = true}) {
  return Container(
    width: width,
    decoration: BoxDecoration(
        color: ColorManager.whiteColor,
        border: Border.all(
          color: ColorManager.blueColor1.withOpacity(.4),
          width: 2,
        )),
    padding: const EdgeInsets.all(1),
    child: TextFormField(
      textAlign: TextAlign.center,
      keyboardType: textInputType,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.all(0),
        border: InputBorder.none,
      ),
      controller: fieldController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'required';
        }
        return null;
      },
      enabled: enable,
    ),
  );
}
