import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geolocator/geolocator.dart';

class DioService {
  late final Dio _dio;

  DioService() {
    final baseOptions = BaseOptions(
      baseUrl: "http://13.235.67.29:9000/api/v1",
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

  Future<List<GeoPoint>>? getPlotPoints() async {
    final response = await _dio.get(
      "/points/",
      options: Options(
        responseType: ResponseType.json,
      ),
    );

    if (response.statusCode == 200) {
      final data = response.data;

      // Transform the data into a list of GeoPoint
      List<GeoPoint> returnData = data.map<GeoPoint>(
            (item) => GeoPoint(
          latitude: item["latitude"],
          longitude: item["longitude"],
        ),
      ).toList();

      return returnData;
    }

    throw Error();
  }
}

final DioService dioService = DioService();
