import 'package:flutter/material.dart';

import '../repository/api_constants.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}

String getBaseUrlFromUrlType(String urlType) {
  switch (urlType) {
    case 'nm':
      return ApiConstants.baseURL;

    default:
      return ApiConstants.baseURL;
  }
}
