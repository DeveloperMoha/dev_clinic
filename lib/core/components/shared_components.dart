import 'package:flutter/cupertino.dart';

class SharedWidgets {
  static Widget horizontalSpace(double space) {
    return SizedBox(
      width: space,
    );
  }

  static Widget verticalSpace(double space) {
    return SizedBox(
      height: space,
    );
  }
}
