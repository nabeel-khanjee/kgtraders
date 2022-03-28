import 'package:flutter/services.dart';
import 'package:location/location.dart';

class GetLocationState {
  final Location location = Location();

  bool _loading = false;

  LocationData? _location;
  String? _error;

   getLocation() async {
    try {
      final LocationData _locationResult = await location.getLocation();
    } on PlatformException catch (err) {
    }
  }

}
