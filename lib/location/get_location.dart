// TODO Implement this library.import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';

class GetLocationState {
  final Location location = Location();

  bool _loading = false;

  LocationData? _location;
  String? _error;

   getLocation() async {
    // setState(() {
    //   _error = null;
    //   _loading = true;
    // });
    try {
      final LocationData _locationResult = await location.getLocation();
      // setState(() {
      //   _location = _locationResult;
      //   _loading = false;
      // });
    } on PlatformException catch (err) {
      // setState(() {
      //   _error = err.code;
      //   _loading = false;
      // });
    }
  }

}
