import 'package:flutter/services.dart';

class AssetsUtils {
  static Future loadAsset2(String path) async {
    try {
      return await rootBundle.loadString(path);
    } catch (_) {
      return null;
    }
  }

  static dynamic loadAsset(String path) {
    dynamic asset;
    rootBundle.load(path).then((a) => asset = a)
        .catchError((_) { });
    return asset;
  }
}
