import 'dart:async';

import 'package:flutter/material.dart';

import '../config/app_constants.dart';
import 'app_extension.dart';

class AppBase {
  late var appPrint = AppPrint();
  late var appErrorPrint = AppErrorPrint();
  late var hideKeyBoard = HideKeyBoard();
  late var showToast = ShowToast();
  late var validString = ValidString();
  late var isFieldEmpty = IsFieldEmpty();
  Timer? apiTimer;

  Future<bool> delayNavigation(int delayDuration) async {
    bool isFinished =
        await Future.delayed(Duration(milliseconds: delayDuration), () {
      return true;
    });
    return isFinished;
  }

  apiDebounce(
    VoidCallback callback, {
    Duration duration = const Duration(
        milliseconds: AppConstants.doubleClickPreventDelayDuration),
  }) {
    if (apiTimer != null) {
      apiTimer!.cancel();
    }

    apiTimer = Timer(duration, callback);
  }
}
