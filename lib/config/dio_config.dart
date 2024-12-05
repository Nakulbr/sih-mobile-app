import 'dart:convert';

import 'package:dio/dio.dart';

class DioService {
  late final Dio _dio;

  DioService() {
    final baseOptions = BaseOptions(
      baseUrl: "http://10.0.2.2:8000/api/v1",
    );

    _dio = Dio(baseOptions);
  }

  Future<Response<dynamic>> uploadPoint({
    required double latitude,
    required double longitude,
    required double speed,
    required double orientation,
    required double elevation,
  }) async {
      final Map<String, double> data = {
        "latitude": latitude,
        "longitude": longitude,
        "speed": speed,
        "orientation": orientation,
        "elevation": elevation,
      };

      final reponse = await _dio.post(
        "/points/",
        data: data,
        options: Options(
          responseType: ResponseType.json,
        ),
      );

      return reponse;
  }
}

final DioService dioService = DioService();
