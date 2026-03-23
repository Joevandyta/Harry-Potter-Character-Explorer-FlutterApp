import 'package:dio/dio.dart';

class ApiClient {

  Dio getDio() {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: 'https://hp-api.onrender.com/',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

        return dio;
  }
}

