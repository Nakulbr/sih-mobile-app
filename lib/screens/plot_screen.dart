import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:sih_hackathon/model/route_model.dart';

class PlotScreen extends StatelessWidget {
  final RouteData route;

  PlotScreen({required this.route});

  @override
  Widget build(BuildContext context) {
    // Create a MapController with the initial position
    final MapController mapController = MapController.withPosition(
      initPosition: route.start, // Initialize map with the starting point
    );

    return Scaffold(
      body: Stack(
        children: [
          OSMFlutter(
            controller: mapController,
            osmOption: OSMOption(),
            onMapIsReady: (isReady) async {
              if (isReady) {
                await plotRoute(
                    mapController); // Call plotRoute after map is ready
              }
            },
          ),
          buildRouteDetails(context),
          buildLegend(),
        ],
      ),
    );
  }

  // Plot the route on the map
  Future<void> plotRoute(MapController mapController) async {
    // Draw the road
    await mapController.drawRoad(
      route.start,
      route.end,
      roadOption: RoadOption(
        roadColor: Colors.blue,
        roadWidth: 5,
      ),
      intersectPoint:
          route.waypoints.map((wp) => wp['location'] as GeoPoint).toList(),
    );

    // Add toll point markers
    for (final tollPoint in route.tollPoints) {
      await mapController.addMarker(
        tollPoint['location'] as GeoPoint,
        markerIcon: MarkerIcon(
          icon: Icon(
            Icons.local_parking,
            color: Colors.red,
            size: 48,
          ),
        ),
      );
    }
  }

  // Route Details UI
  Widget buildRouteDetails(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Start: ${route.startName}", style: TextStyle(fontSize: 16)),
              Text("End: ${route.endName}", style: TextStyle(fontSize: 16)),
              if (route.tollPoints.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Text("Toll Points:", style: TextStyle(fontSize: 16)),
                    ...route.tollPoints
                        .map((toll) => Text("- ${toll['name']}"))
                        .toList(),
                  ],
                ),
              SizedBox(height: 10),
              Text(
                "Total Expenses: ${route.expenses}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Back to History"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Legend for the map
  Widget buildLegend() {
    return Positioned(
      top: 20,
      right: 20,
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(width: 20, height: 20, color: Colors.blue),
                  SizedBox(width: 8),
                  Text("Route"),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(Icons.local_parking, color: Colors.red, size: 20),
                  SizedBox(width: 8),
                  Text("Toll Point"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
