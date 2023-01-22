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

  Future notification() async {
    dio.options.headers["Authorization"] =
        "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvcG9ydGFsLnczY2VydC5pblwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTY3NDI5NDcxOSwiZXhwIjoxNzA1ODMwNzE5LCJuYmYiOjE2NzQyOTQ3MTksImp0aSI6ImJKMzlKdDhiN3ZYNlhISFIiLCJzdWIiOjEzLCJwcnYiOiI4MThmNWM5OGFjZTIzNzUzMmQ5ZDQ5NDNmZDhlZmI1NDBiODU1YjQyIiwicmVtZW1iZXIiOjEsInR5cGUiOjF9.FmNuwi8DKABQxSzmuR7iri6q5mBfqW9RC2rJUevLc98 ";

    try {
      Response response = await dio.get(
        "notification",
      );

      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }
}
