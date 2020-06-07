import 'dart:io' show Platform;

import 'package:flutter/widgets.dart';

class ScaleFactor {
  static double scalingHeight(
      BuildContext context, double androidHeight, double iosHeight) {
    if (Platform.isAndroid) {
      return MediaQuery.of(context).size.height / androidHeight;
    } else if (Platform.isIOS) {
      return MediaQuery.of(context).size.height / iosHeight;
    }
  }
}
