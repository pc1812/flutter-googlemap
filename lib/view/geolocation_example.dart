
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GeolocationExample extends StatefulWidget {
  @override
  GeolocationExampleState createState() => new GeolocationExampleState();
}


class GeolocationExampleState extends State {
  Geolocator _geolocator;
  Position _position;
  
  void checkPermission() {
    _geolocator.checkGeolocationPermissionStatus().then((status) { print('status: $status'); });
    _geolocator.checkGeolocationPermissionStatus(locationPermission: GeolocationPermission.locationAlways).then((status) { print('always status: $status'); });
    _geolocator.checkGeolocationPermissionStatus(locationPermission: GeolocationPermission.locationWhenInUse)..then((status) { print('whenInUse status: $status'); });
  }
  
  @override
  void initState() {
    super.initState();
  
    _geolocator = Geolocator();
    LocationOptions locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 0);
  
    checkPermission();
    // updateLocation();

    Stream<Position> stream = _geolocator.getPositionStream(locationOptions);
    StreamSubscription<Position> streamSub = stream.listen(
      (Position position) {
        _position = position;
      })
    ;
  }
  
  void updateLocation() async {
    try {
      Position newPosition = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .timeout(new Duration(seconds: 5));
  
      setState(() {
        _position = newPosition;
      });
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: Center(
        child: Text(
          'Latitude: ${_position != null ? _position.latitude.toString() : '0'},'
          ' Longitude: ${_position != null ? _position.longitude.toString() : '0'}'
        )
      ),
    );
  }
}
