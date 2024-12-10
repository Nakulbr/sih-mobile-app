import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class RouteData {
  final String title;
  final String startName;
  final GeoPoint start;
  final String endName;
  final GeoPoint end;
  final List<Map<String, dynamic>> waypoints; // Includes name and location
  final List<Map<String, dynamic>> tollPoints; // Includes name and location
  final String expenses;

  RouteData({
    required this.title,
    required this.startName,
    required this.start,
    required this.endName,
    required this.end,
    required this.waypoints,
    required this.tollPoints,
    required this.expenses,
  });
}
