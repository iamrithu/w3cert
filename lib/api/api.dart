import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:w3cert/constant/const-var.dart';

class API {
  final dio = Dio(BaseOptions(
    connectTimeout: 30000,
    baseUrl: ConstVar.BASE_URL,
    responseType: ResponseType.json,
    contentType: ContentType.json.toString(),
  ));
  Future authendication(String email, String password) async {
    try {
      var params = {"email": email, "password": password};
      Response response = await dio.post(
        "auth/login",
        data: jsonEncode(params),
      );

      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future notification(String? token) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    try {
      Response response = await dio.get(
        "notification",
      );

      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future task(String? token) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    try {
      Response response = await dio.get(
        "task",
      );
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }
}
