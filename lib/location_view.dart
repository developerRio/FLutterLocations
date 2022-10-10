import 'package:flutter/material.dart';
import 'package:flutter_location/location_worker.dart';
import 'package:location/location.dart';

class LocationView extends StatefulWidget {
  const LocationView({Key? key}) : super(key: key);

  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  LocationData? _locationData;

  fetchLocation() async {
    LocationWorker locationWorker = const LocationWorker();
    await locationWorker.fetchLocationsDataAlongWithPermissions().getLocation().then((LocationData mLocationData) {
      setState(() {
        _locationData = mLocationData;
      });
    }).catchError((e) {
      print("SomeErrorCameUp : $e");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Latitude: ${_locationData?.latitude ?? ""}'),
              Text('Longitude: ${_locationData?.longitude ?? ""}'),
              Text('Accuracy(in meters): ${_locationData?.accuracy ?? ""}'),
              Text('Time: ${_locationData?.time ?? ""}'),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  fetchLocation();
                },
                child: const Text("Get Current Location"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
