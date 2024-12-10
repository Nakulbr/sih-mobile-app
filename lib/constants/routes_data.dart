import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:sih_hackathon/model/route_model.dart';

List<RouteData> travelHistory = [
  RouteData(
    title: "Route 1: Gandhipuram to Avinashi",
    startName: "Gandhipuram Bus Stand",
    start: GeoPoint(latitude: 11.0168, longitude: 76.9558),
    endName: "Avinashi Town",
    end: GeoPoint(latitude: 11.1920, longitude: 77.2680),
    waypoints: [
      {"name": "Hopes College", "location": GeoPoint(latitude: 11.0134, longitude: 76.9679)},
      {"name": "Neelambur Bypass", "location": GeoPoint(latitude: 11.0380, longitude: 77.0163)},
    ],
    tollPoints: [
      {"name": "Neelambur Toll Plaza", "location": GeoPoint(latitude: 11.0675, longitude: 77.0662)},
    ],
    expenses: "₹50",
  ),
  RouteData(
    title: "Route 2: Coimbatore to Pollachi",
    startName: "Ukkadam Bus Stand",
    start: GeoPoint(latitude: 10.9975, longitude: 76.9471),
    endName: "Pollachi New Bus Stand",
    end: GeoPoint(latitude: 10.6600, longitude: 77.0098),
    waypoints: [
      {"name": "Kinathukadavu", "location": GeoPoint(latitude: 10.8680, longitude: 77.0058)},
    ],
    tollPoints: [
      {"name": "Kinathukadavu Toll Plaza", "location": GeoPoint(latitude: 10.8728, longitude: 77.0125)},
    ],
    expenses: "₹30",
  ),
  RouteData(
    title: "Route 3: Coimbatore Airport to Salem",
    startName: "Coimbatore International Airport",
    start: GeoPoint(latitude: 11.0286, longitude: 77.0434),
    endName: "Salem New Bus Stand",
    end: GeoPoint(latitude: 11.6538, longitude: 78.1570),
    waypoints: [
      {"name": "Neelambur Bypass", "location": GeoPoint(latitude: 11.0380, longitude: 77.0163)},
      {"name": "Avinashi Bypass", "location": GeoPoint(latitude: 11.1720, longitude: 77.2590)},
    ],
    tollPoints: [
      {"name": "Neelambur Toll Plaza", "location": GeoPoint(latitude: 11.0675, longitude: 77.0662)},
      {"name": "Omalur Toll Plaza", "location": GeoPoint(latitude: 11.6990, longitude: 78.0582)},
    ],
    expenses: "₹120",
  ),
  RouteData(
    title: "Route 4: Gandhipuram to Marudhamalai",
    startName: "Gandhipuram Bus Stand",
    start: GeoPoint(latitude: 11.0168, longitude: 76.9558),
    endName: "Marudhamalai Temple",
    end: GeoPoint(latitude: 11.0526, longitude: 76.8993),
    waypoints: [
      {"name": "Saibaba Colony", "location": GeoPoint(latitude: 11.0257, longitude: 76.9447)},
    ],
    tollPoints: [],
    expenses: "₹0",
  ),
  RouteData(
    title: "Route 5: Perur to Mettupalayam",
    startName: "Perur Temple",
    start: GeoPoint(latitude: 10.9845, longitude: 76.9132),
    endName: "Mettupalayam Town",
    end: GeoPoint(latitude: 11.2992, longitude: 76.9378),
    waypoints: [
      {"name": "Kovilpalayam", "location": GeoPoint(latitude: 11.1525, longitude: 76.9942)},
    ],
    tollPoints: [
      {"name": "Vellanaipatti Toll Plaza", "location": GeoPoint(latitude: 11.2020, longitude: 77.0548)},
    ],
    expenses: "₹40",
  ),
];
