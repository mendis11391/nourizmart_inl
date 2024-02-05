import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../config/app_constants.dart';
import '../config/app_enums.dart';
import '../config/app_string.dart';

class AppPrint {
  AppPrint._privateConstructor();
  static final AppPrint _instance = AppPrint._privateConstructor();
  factory AppPrint() {
    return _instance;
  }

  call(dynamic msg) {
    if (!AppConstants.inProduction) {
      developer.log('$msg');
    }
  }

  static void getStaticPrint(dynamic e, {int printType = 1}) {
    if (!AppConstants.inProduction) {
      switch (printType) {
        case 2:
          printRequest(e);
          break;
        case 3:
          printResponse(e);
          break;
        default:
          developer.log('$e');
          break;
      }
    }
  }
}

void printRequest(dynamic text) {
  developer.log('\x1B[36m$text\x1B[0m');
}

void printResponse(dynamic text) {
  developer.log('\x1B[34m$text\x1B[0m');
}

class AppErrorPrint {
  AppErrorPrint._privateConstructor();
  static final AppErrorPrint _instance = AppErrorPrint._privateConstructor();
  factory AppErrorPrint() {
    return _instance;
  }

  call(dynamic msg) {
    if (!AppConstants.inProduction) {
      printError('🛑 $msg');
    }
  }

  static void getStaticPrint(dynamic e) {
    if (!AppConstants.inProduction) {
      printError('🛑 $e');
    }
  }
}

void printError(String text) {
  developer.log('\x1B[31m$text\x1B[0m');
}

class HideKeyBoard {
  HideKeyBoard._privateConstructor();
  static final HideKeyBoard _instance = HideKeyBoard._privateConstructor();
  factory HideKeyBoard() {
    return _instance;
  }

  call() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

class ShowToast {
  ShowToast._privateConstructor();
  static final ShowToast _instance = ShowToast._privateConstructor();
  factory ShowToast() {
    return _instance;
  }

  call(String msg, {int msgType = 1}) {
    msg = (msg.toString().trim().isEmpty ||
            msg.toString().trim().toLowerCase() == 'null')
        ? AppStrings.errorDiaWentWrong
        : msg.toString();
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: msg,
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_SHORT,
        textColor: Colors.white,
        timeInSecForIosWeb: 1,
        backgroundColor:
            msgType == ToastType.error.value ? Colors.red : Colors.blueGrey);
  }
}

class ValidString {
  ValidString._privateConstructor();
  static final ValidString _instance = ValidString._privateConstructor();
  factory ValidString() {
    return _instance;
  }

  call(dynamic input) {
    return input == null ||
            input.toString().trim().isEmpty ||
            input.toString().trim().toLowerCase() == 'null'
        ? ''
        : input.toString().trim();
  }
}

class IsFieldEmpty {
  IsFieldEmpty._privateConstructor();
  static final IsFieldEmpty _instance = IsFieldEmpty._privateConstructor();
  factory IsFieldEmpty() {
    return _instance;
  }

  call(dynamic input) {
    return input == null || input.toString().trim().isEmpty;
  }
}
