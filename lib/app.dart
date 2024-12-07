import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sih_hackathon/config/dio_config.dart';
import 'package:sih_hackathon/config/geolocator_config.dart';
import 'package:sih_hackathon/screens/plot_screen.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late MapController _controller;
  late GeolocatorService _geolocatorService;
  StreamSubscription<Position>? _positionSubscription;
  Timer? _timer;
  bool _isSendingData = false;

  @override
  void initState() {
    super.initState();
    initializeOSM();

    _geolocatorService = GeolocatorService();

    listenToPositionUpdates();
  }

  Future<void> initializeOSM() async {
    _controller = MapController.withPosition(
      initPosition: GeoPoint(latitude: 0, longitude: 0),
    );
    // await _controller.startLocationUpdating();
  }

  void listenToPositionUpdates() {
    _positionSubscription = _geolocatorService.positionStream.listen(
      (Position position) async {
        try {
          // Update the OSM map with the current position and heading
          await _controller.moveTo(
            GeoPoint(
                latitude: position.latitude, longitude: position.longitude),
            animate: true,
          );

          // Update the direction of the marker if the heading is valid
          // if (position.heading >= 0) {
          //   await _controller.setMarkerOrientation(
          //     GeoPoint(
          //       latitude: position.latitude,
          //       longitude: position.longitude,
          //     ),
          //     position.heading,
          //   );
          // }
        } catch (e) {
          print("Error updating map or marker orientation: $e");
        }
      },
      onError: (error) {
        print("Error fetching location: $error");
      },
    );
  }

  Future<void> _getLocationDataAndSend() async {
    try {
      // GeoPoint? currentLocation = await _controller.myLocation();
      // if (currentLocation == null) {
      //   print("Failed to get location from OSM");
      //   return;
      // }

      Position position = await Geolocator.getCurrentPosition();

      double latitude = position.latitude;
      double longitude = position.longitude;
      double elevation = position.altitude;
      double speed = position.speed;
      double orientation = position.heading;

      print("Latitude : $latitude");
      print("Longitude : $longitude");
      print("Elevation : $elevation");
      print("Speed : $speed");
      print("Orientation : $orientation");

      await _sendLocationDataToBackend(
          latitude, longitude, elevation, speed, orientation);
    } catch (e) {
      print("Error fetching location data: $e");
    }
  }

  Future<void> _sendLocationDataToBackend(double latitude, double longitude,
      double elevation, double speed, double orientation) async {
    try {
      final response = await dioService.uploadPoint(
        latitude: latitude,
        longitude: longitude,
        speed: speed,
        orientation: orientation,
        elevation: elevation,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.fromLTRB(
              10, 30, 10, MediaQuery.of(context).size.height - 100),
          content: Text("The server status code is ${response.statusCode}"),
        ),
        snackBarAnimationStyle: AnimationStyle(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        ),
      );
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
    _positionSubscription?.cancel();
    _geolocatorService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PlotScreen(),
                  ),
                );
              },
              child: const Icon(Icons.arrow_circle_right_outlined, size: 30,),
            ),
          )
        ],
      ),
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
                initZoom: 12,
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
                  StreamBuilder<Position>(
                    stream: _geolocatorService.positionStream,
                    builder: (context, snapshot) {
                      // Handle loading and error states
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(); // Display a loading spinner while waiting for data
                      }

                      if (snapshot.hasError) {
                        return Text(
                          "Error: ${snapshot.error}",
                          style: const TextStyle(color: Colors.red),
                        ); // Display an error message if there's an issue with the stream
                      }

                      // Handle the data state
                      if (snapshot.hasData) {
                        Position data = snapshot
                            .data!; // Since hasData is true, data is non-null
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Latitude: ${data.latitude}"),
                            Text("Longitude: ${data.longitude}"),
                            Text("Speed: ${data.speed.toStringAsFixed(2)} m/s"),
                            Text(
                                "Orientation: ${data.heading.toStringAsFixed(2)}°"),
                            Text(
                                "Elevation: ${data.altitude.toStringAsFixed(2)} m"),
                          ],
                        );
                      }

                      // Handle the case where there's no data yet (shouldn't happen if stream emits data)
                      return const Text("No data available");
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
