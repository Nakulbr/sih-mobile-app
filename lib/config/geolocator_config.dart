import 'dart:async';
import 'package:geolocator/geolocator.dart';

class GeolocatorService {
  late LocationSettings locationSettings;
  final _positionController = StreamController<Position>.broadcast();
  StreamSubscription<Position>? _subscription;

  Stream<Position> get positionStream => _positionController.stream;

  GeolocatorService({
    LocationAccuracy accuracy = LocationAccuracy.high,
    int distanceFilter = 0,
  }) {
    initialize(accuracy, distanceFilter);
  }

  Future<void> initialize(LocationAccuracy accuracy, int distanceFilter) async {
    await getLocationPermission();

    // Configure location settings
    locationSettings = LocationSettings(
      accuracy: accuracy,
      distanceFilter: distanceFilter,
    );

    // Start listening to location updates
    getCurrentLocation();
  }

  void getCurrentLocation() {
    try {
      _subscription = Geolocator.getPositionStream(
        locationSettings: locationSettings,
      ).listen(
            (Position? position) {
          if (position != null) {
            _positionController.add(position);
          }
        },
        onError: (error) {
          _positionController.addError("Error fetching location: $error");
        },
      );
    } catch (e) {
      _positionController.addError("Error initializing location stream: $e");
    }
  }

  Future<void> getLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        throw Exception("Location Services are disabled");
      }

      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          throw Exception("Location permission denied");
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
    } catch (e) {
      _positionController.addError("Permission error: $e");
      rethrow;
    }
  }

  void stopLocationUpdates() {
    _subscription?.cancel();
    _subscription = null;
  }

  void dispose() {
    stopLocationUpdates();
    _positionController.close();
  }
}
