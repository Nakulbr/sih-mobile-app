import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sih_hackathon/config/dio_config.dart';
import 'package:sih_hackathon/config/geolocator_config.dart';
import 'package:sih_hackathon/constants/colors.dart';
import 'package:sih_hackathon/screens/plot_screen.dart';
import 'package:sih_hackathon/widgets/custom_elevated_button.dart';
import 'package:sih_hackathon/widgets/home_screen_model_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final MapController _controller;
  late final GeolocatorService _geolocatorService;
  final ValueNotifier<bool> _isSendingData = ValueNotifier(false);
  StreamSubscription<Position>? _positionSubscription;
  Timer? _timer;

  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _geolocatorService = GeolocatorService();
    _controller = MapController.withPosition(
      initPosition: GeoPoint(latitude: 0, longitude: 0),
    );

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _rotationAnimation =
        Tween<double>(begin: 0, end: 3.14 / 20).animate(_animationController);
    _scaleAnimation =
        Tween<double>(begin: 1, end: 2.7).animate(_animationController);
    _offsetAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(0, 5))
            .animate(_animationController);

    _initializePositionStream();
  }

  void _initializePositionStream() {
    _positionSubscription = _geolocatorService.positionStream.listen(
      (Position position) async {
        await _updateMapLocation(position);
      },
      onError: (error) => debugPrint("Error fetching location: $error"),
    );
  }

  Future<void> _updateMapLocation(Position position) async {
    try {
      await _controller.moveTo(
        GeoPoint(latitude: position.latitude, longitude: position.longitude),
        animate: true,
      );
    } catch (e) {
      debugPrint("Error updating map: $e");
    }
  }

  void _startDataTransmission() {
    if (!_isSendingData.value) {
      _isSendingData.value = true;
      _animationController.forward(); // Start the animation
      _timer = Timer.periodic(const Duration(seconds: 1), (_) async {
        try {
          final Position position = await Geolocator.getCurrentPosition();
          await _sendLocationData(position);
        } catch (e) {
          debugPrint("Error during periodic data sending: $e");
        }
      });
    }
  }

  void _stopDataTransmission() {
    _timer?.cancel();
    _isSendingData.value = false;
    _animationController.reverse(); // Reverse the animation to original state
  }

  Future<void> _sendLocationData(Position position) async {
    final double speedKmH = position.speed * 3.6;
    try {
      await dioService.uploadPoint(
        latitude: position.latitude,
        longitude: position.longitude,
        speed: speedKmH,
        orientation: position.heading,
        elevation: position.altitude,
      );
    } catch (e) {
      debugPrint("Error sending data to backend: $e");
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    _timer?.cancel();
    _positionSubscription?.cancel();
    _isSendingData.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, -0.01)
                  ..rotateX(_rotationAnimation.value)
                  ..scale(_scaleAnimation.value)
                  ..translate(_offsetAnimation.value.dx),
                alignment: FractionalOffset.center,
                child: OSMFlutter(
                  controller: _controller,
                  mapIsLoading: const Center(
                    child: SpinKitFadingCube(
                      color: primaryColor,
                    ),
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
                        icon: Icon(Icons.location_on,
                            color: Colors.blue, size: 100),
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
                    roadConfiguration:
                        const RoadOption(roadColor: Colors.yellowAccent),
                  ),
                ),
              );
            },
          ),
          // Speedometer
          Positioned(
            top: 50,
            left: 16,
            child: StreamBuilder<Position>(
              stream: _geolocatorService.positionStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final double speedKmH = snapshot.data!.speed * 3.6;
                  return Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "${speedKmH.toStringAsFixed(2)} km/h",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          // Start and Stop Buttons
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: SizedBox(
              height: 150,
              child: ValueListenableBuilder<bool>(
                valueListenable: _isSendingData,
                builder: (context, isSendingData, _) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomElevatedButton(
                        onPressed:
                            isSendingData ? null : _startDataTransmission,
                        content: "Start",
                        width: 150,
                      ),
                      CustomElevatedButton(
                        onPressed: isSendingData ? _stopDataTransmission : null,
                        content: "Stop",
                        width: 150,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          const HomeScreenModelSheet(),
        ],
      ),
    );
  }
}
