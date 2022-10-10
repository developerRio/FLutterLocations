import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationWorker extends StatefulWidget {
  const LocationWorker({Key? key}) : super(key: key);

  @override
  State<LocationWorker> createState() => _LocationWorkerState();

  Location fetchLocationsDataAlongWithPermissions() {
    return _LocationWorkerState().location;
  }
}

class _LocationWorkerState extends State<LocationWorker> {
  Location location = Location();
  bool? _serviceEnabled;
  PermissionStatus? _permissionStatus;
  LocationData? locationData;

  Future<bool> _handleLocationPermission() async {
    _serviceEnabled = await location.serviceEnabled();

    if (!_serviceEnabled!) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    _permissionStatus = await location.hasPermission();
    if (_permissionStatus == PermissionStatus.denied) {
      _permissionStatus = await location.requestPermission();
      if (_permissionStatus == PermissionStatus.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (_permissionStatus == PermissionStatus.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, open the settings & enable location permissions to use this feature.')));
      return false;
    }
    return true;
  }

  Future<LocationData?> getCurrentPosition() async {
    print("fetching location...");
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return locationData;
    await location.getLocation().then((LocationData mLocationData) {
      locationData = mLocationData;
      print("location fetched !!!");
      return locationData;
      //_getAddressFromLatLng(_locationData);
    }).catchError((e) {
      print("SomeErrorCameUp : $e");
      return locationData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(),
    );
  }

  void _getAddressFromLatLng(LocationData locationData) {}

}
