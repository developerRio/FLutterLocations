import 'package:flutter/material.dart';
import 'package:flutter_location/fetch_location_worker.dart';
import 'package:flutter_location/qr_scanner_worker.dart';
import 'package:flutter_location/snackbar_widget.dart';
import 'package:location/location.dart';

class LocationView extends StatefulWidget {
  const LocationView({Key? key}) : super(key: key);

  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  LocationsWorker? locationWorker;
  LocationData? _locationData;

  fetchLocation() {
    locationWorker = LocationsWorker(
      callback: (locationData) {
        setState(() {
          _locationData = locationData;
        });
      },
      context: context,
    ).initLocation();
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
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => QRScannerScreen(
                        callback: (String result) {
                          print("scanned_result : $result");
                          showSnackBar(context, result);
                        },
                      ),
                    ),
                  );
                },
                child: const Text("Scan QR Code"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
