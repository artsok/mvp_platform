import 'package:flutter/services.dart';

class AssetsUtils {

  static dynamic loadAsset(String path) {
    dynamic asset;
    rootBundle.load(path).then((a) {
      asset = a;
    }).catchError((err) {
      print('$err');
    });
    return asset;
  }
}
