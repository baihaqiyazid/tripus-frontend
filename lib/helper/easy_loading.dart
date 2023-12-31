import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';

class Loading {
  static void showInfo(String message) {
    EasyLoading.instance
      ..displayDuration = Duration(milliseconds: 600)
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = Colors.orangeAccent;
    EasyLoading.showInfo(message);
  }
}