import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;

class GetUserLocation {
  bool _serviceEnabled = false;
  loc.PermissionStatus? _permissionGranted;
  loc.LocationData? _userLocation;
  String _locationName = '';

  String get locationName => _locationName;

  Future<void> getUserLocation() async {
    loc.Location location = loc.Location();

    // Check if location service is enabled
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    // Check if permission is granted
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    final locationData = await location.getLocation();
    _userLocation = locationData;

    getLocationName(
        _userLocation?.latitude ?? 0, _userLocation?.longitude ?? 0);
  }

  Future<void> getLocationName(double latitude, double longitude) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    Placemark place = placemarks[0];

    _locationName = "${place.locality}, ${place.country}";

    print(_locationName);
  }
}
