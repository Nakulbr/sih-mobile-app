import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:sih_hackathon/config/dio_config.dart';

class PlotScreen extends StatefulWidget {
  const PlotScreen({super.key});

  @override
  State<PlotScreen> createState() => _PlotScreenState();
}

class _PlotScreenState extends State<PlotScreen> {
  late MapController _controller;
  bool _isRoadDrawn = false;
  List<GeoPoint>? geoPoints;

  @override
  void initState() {
    _controller = MapController.withPosition(
      initPosition: GeoPoint(latitude: 11, longitude: 76),
    );
    super.initState();
    fetchGeoPoints();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> fetchGeoPoints() async {
    try {
      final points = await dioService.getPlotPoints();
      setState(() {
        geoPoints = points;
      });
    } catch (e) {
      debugPrint("Error fetching GeoPoints: $e");
    }
  }

  Future<void> drawRoad() async {
    try {
      if (geoPoints == null || geoPoints!.length < 2) {
        debugPrint("Insufficient points to draw a road");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Not enough points to draw a road")),
        );
        return;
      }

      await _controller.moveTo(geoPoints!.first);

      await _controller.drawRoadManually(
        geoPoints!,
        const RoadOption(
          roadColor: Colors.blue,
          zoomInto: true,
        ),
      );

      setState(() {
        _isRoadDrawn = true;
      });
    } catch (e) {
      debugPrint("Error drawing road: ${e.toString()}");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to draw road")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: geoPoints == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                OSMFlutter(
                  controller: _controller,
                  osmOption: OSMOption(
                    zoomOption: const ZoomOption(
                      initZoom: 8,
                      minZoomLevel: 3,
                      maxZoomLevel: 19,
                      stepZoom: 1.0,
                    ),
                    userLocationMarker: UserLocationMaker(
                      personMarker: const MarkerIcon(
                        icon: Icon(Icons.location_on),
                      ),
                      directionArrowMarker: const MarkerIcon(
                        icon: Icon(Icons.arrow_circle_right),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                    onPressed: drawRoad,
                    child: const Text("Draw Road"),
                  ),
                ),
              ],
            ),
    );
  }
}
