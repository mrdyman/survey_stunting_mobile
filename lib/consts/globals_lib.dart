library globals;

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import '../services/dio_client.dart';

/// Return true if connected
Future<bool> isConnected() async {
  try {
    bool response = await DioClient().testConnection(
      token: GetStorage().read("token"),
    );
    if (response) {
      return true;
    }
    return false;
  } on DioError catch (e) {
    log('something Wrong on checking network connection :' + e.toString());
    return false;
  }
}
