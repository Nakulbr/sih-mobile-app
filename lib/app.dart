import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sih_hackathon/config/dio_config.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late MapController _controller;
  Timer? _timer;
  bool _isSendingData = false;

  @override
  void initState() {
    _controller = MapController.withUserPosition(
      trackUserLocation: const UserTrackingOption(
        enableTracking: true,
      ),
    );
    initializeOSM();
    super.initState();
  }

  Future<void> initializeOSM() async {
    await _controller.startLocationUpdating();
  }

  Future<void> _getLocationDataAndSend() async {
    try {
      GeoPoint? currentLocation = await _controller.myLocation();
      if (currentLocation == null) {
        print("Failed to get location from OSM");
        return;
      }

      Position position = await Geolocator.getCurrentPosition();

      double latitude = currentLocation.latitude;
      double longitude = currentLocation.longitude;
      double elevation = position.altitude;
      double speed = position.speed;
      double orientation = position.heading;

      await _sendLocationDataToBackend(latitude, longitude, elevation, speed, orientation);
    } catch (e) {
      print("Error fetching location data: $e");
    }
  }

  Future<void> _sendLocationDataToBackend(
      double latitude, double longitude, double elevation, double speed, double orientation) async {
    try {
      final response = await dioService.uploadPoint(
        latitude: latitude,
        longitude: longitude,
        elevation: elevation,
        speed: speed,
        orientation: orientation,
      );

      print("Data sent successfully: ${response.statusCode}");
    } catch (e) {
      print("Error sending data to backend: $e");
    }
  }

  void _startSendingData() {
    if (!_isSendingData) {
      setState(() {
        _isSendingData = true;
      });

      _timer = Timer.periodic(const Duration(seconds: 5), (_) {
        _getLocationDataAndSend();
      });
    }
  }

  void _stopSendingData() {
    if (_isSendingData) {
      _timer?.cancel();
      setState(() {
        _isSendingData = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          OSMFlutter(
            controller: _controller,
            mapIsLoading: const Center(
              child: CircularProgressIndicator(),
            ),
            osmOption: OSMOption(
              userTrackingOption: const UserTrackingOption(
                enableTracking: true,
                unFollowUser: false,
              ),
              zoomOption: const ZoomOption(
                initZoom: 8,
                minZoomLevel: 3,
                maxZoomLevel: 19,
                stepZoom: 1.0,
              ),
              userLocationMarker: UserLocationMaker(
                personMarker: const MarkerIcon(
                  icon: Icon(
                    Icons.location_on,
                    color: Colors.blue,
                    size: 100,
                  ),
                ),
                directionArrowMarker: MarkerIcon(
                  iconWidget: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Icon(
                      Icons.double_arrow_rounded,
                      color: Colors.white,
                      size: 100,
                    ),
                  ),
                ),
              ),
              roadConfiguration: const RoadOption(
                roadColor: Colors.yellowAccent,
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: SizedBox(
              height: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _isSendingData ? null : _startSendingData,
                    child: const Text("Start"),
                  ),
                  ElevatedButton(
                    onPressed: _isSendingData ? _stopSendingData : null,
                    child: const Text("Stop"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}