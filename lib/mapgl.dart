import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:flutter/material.dart';

class ViewBox extends StatefulWidget {
  const ViewBox({Key? key}) : super(key: key);

  @override
  State<ViewBox> createState() => _ViewBoxState();
}

class _ViewBoxState extends State<ViewBox> {
  Future<LatLng?> acquireCurrentLocation() async {
    // Initializes the plugin and starts listening for potential platform events
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    // Gets the current location of the user
    final locationData = await location.getLocation();
    LatLng Latlong = LatLng(
        locationData.latitude as double, locationData.longitude as double);
    return Latlong;
  }

  late MapboxMapController controller;
  void _mapCreate(MapboxMapController controller) async {
    this.controller = controller;
    final result = await acquireCurrentLocation() as LatLng;

    await controller.animateCamera(
      CameraUpdate.newLatLng(result),
    );
    await controller.addCircle(
      CircleOptions(
        circleRadius: 8.0,
        circleColor: '#FF0000',
        circleOpacity: 0.8,
        geometry: result,
        draggable: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String token =
        'pk.eyJ1IjoiYW5kYWxhbmd1IiwiYSI6ImNsMnVlOWRlNjAxNjgzY3Jxb2hvb2xidTMifQ.K3sCVYf7NoKNBaCWa9qFlA';
    final String style = 'mapbox://styles/andalangu/cl2ueg701000w14pobkyikmta';

    return Scaffold(
      body: MapboxMap(
          accessToken: token,
          styleString: style,
          initialCameraPosition: const CameraPosition(
            zoom: 15.0,
            target: LatLng(14.508, 46.048),
          ),

          // The onMapCreated callback should be used for everything related
          // to updating map components via the MapboxMapController instance
          onMapCreated: _mapCreate),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff091122),
        elevation: 2,
        child: const Icon(Icons.location_searching),
        onPressed: () async {
          final result = await acquireCurrentLocation() as LatLng;
          late CameraPosition _initialCameraPosition =
              CameraPosition(target: result, zoom: 15);
          controller.animateCamera(
              CameraUpdate.newCameraPosition(_initialCameraPosition));
        },
      ),
    );
  }
}
