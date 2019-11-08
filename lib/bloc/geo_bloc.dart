
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';

class GeoBloc with ChangeNotifier {
  Geolocator _geolocator = Geolocator();

  LocationOptions locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 0);

  Position _position;

  Position get position => _position;

  String get googleUrl {
    if (_position != null && _position.latitude != null && _position.longitude != null) {
      return 'https://www.google.com/maps?q=' + _position.latitude.toString() + ',' + _position.longitude.toString();
    }
    else {
      return 'https://www.google.com/maps?q=51.5074,0.1278';
    }
  }

  GeoBloc() {
    _geolocator.checkGeolocationPermissionStatus().then((status) { print('status: $status'); });
    _geolocator.checkGeolocationPermissionStatus(locationPermission: GeolocationPermission.locationAlways).then((status) { print('always status: $status'); });
    _geolocator.checkGeolocationPermissionStatus(locationPermission: GeolocationPermission.locationWhenInUse)..then((status) { print('whenInUse status: $status'); });
  
    Stream<Position> stream = _geolocator.getPositionStream(locationOptions);
    stream.listen(
      (Position position) {
        _position = position;
        notifyListeners();
      }
    );
  }
  
  


}