import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:arborrr_p001/home.dart' as main;
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as dev;

final connect =
    FirebaseFirestore.instance.collection('technicials').snapshots();
bool acceptionBtn = true;

class ViewBox extends StatefulWidget {
  const ViewBox({Key? key}) : super(key: key);

  @override
  State<ViewBox> createState() => _ViewBoxState();
}

class _ViewBoxState extends State<ViewBox> {
  @override
  void initState() {
    super.initState();
  }

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
    LatLng latLong = LatLng(
        locationData.latitude as double, locationData.longitude as double);
    return latLong;
  }

  late MapboxMapController controller;
  void _mapCreate(MapboxMapController controller) async {
    this.controller = controller;
    final result = await acquireCurrentLocation() as LatLng;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: result, zoom: 15)));
    addPin('#ffffff', 8.313, 98.3995617);
  }

  @override
  Widget build(BuildContext context) {
    const String token =
        'pk.eyJ1IjoiYW5kYWxhbmd1IiwiYSI6ImNsMnVlOWRlNjAxNjgzY3Jxb2hvb2xidTMifQ.K3sCVYf7NoKNBaCWa9qFlA';
    const String style = 'mapbox://styles/andalangu/cl2ueg701000w14pobkyikmta';
    return Scaffold(
      body: Material(
        child: MapboxMap(
            accessToken: token,
            styleString: style,
            myLocationEnabled: true,
            initialCameraPosition: const CameraPosition(
              zoom: 15.0,
              target: LatLng(14.508, 46.048),
            ),
            onMapCreated: _mapCreate),
      ),
      floatingActionButton: Wrap(
          spacing: 10,
          direction: Axis.vertical,
          alignment: WrapAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 310),
              child: FloatingActionButton(
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
            ),
            Visibility(
              visible: acceptionBtn,
              child: Container(
                padding: const EdgeInsets.only(left: 21),
                margin: const EdgeInsets.only(bottom: 15),
                width: MediaQuery.of(context).size.width - 10,
                height: 54,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 2, primary: const Color(0xFF4059ad)),
                    onPressed: () async {
                      acceptionBtn = false;
                      final locationData = await Location().getLocation();
                      dev.log(
                          '${locationData.latitude} ${locationData.longitude}');
                      //วัดระยะของผู้ใช้กับพื้นที่ให้บริการ
                      //ถ้ามีหลายๆที่ให้ทำเป็นลิสต์
                      final prefs = await SharedPreferences.getInstance();
                      var distancing = await getDistanceFromLatLonInKm(
                          8.313,
                          98.3995617,
                          locationData.latitude,
                          locationData.longitude);
                      await prefs.setDouble('ClientStay', distancing);
                      await prefs.setDouble('LatUser', locationData.latitude!);
                      await prefs.setDouble('LonUser', locationData.longitude!);
                      await main.serviceCheck();
                      dev.log('Distance : ${distancing.toStringAsFixed(4)}Km');
                      setState(() {});
                    },
                    child: const Text('ยืนยันตำแหน่ง')),
              ),
            ),
            Visibility(
              visible: !acceptionBtn,
              child: Container(
                padding: const EdgeInsets.only(left: 21),
                margin: const EdgeInsets.only(bottom: 27),
                height: 54,
                width: MediaQuery.of(context).size.width - 10,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 2,
                      primary: const Color.fromARGB(230, 254, 53, 93)),
                  child: const Text('เปลี่ยนตำแหน่งใหม่'),
                  onPressed: () async {
                    acceptionBtn = true;
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setDouble('ClientStay', 50);
                    await main.serviceCheck();
                    setState(() {});
                  },
                ),
              ),
            ),
          ]),
    );
  }

  //UI Part
  addPin(String color, double lat, double lon) {
    return controller.addCircle(CircleOptions(
      circleRadius: 8.0,
      circleColor: color,
      circleOpacity: 0.8,
      geometry: LatLng(lat, lon),
      draggable: false,
    ));
  }

  //BackEnd part
// calculate distance user and tecnicial
  getDistanceFromLatLonInKm(latS, lonS, latC, lonC) {
    var R = 6371; // Radius of the earth in km
    var dLat = deg2rad(latC - latS); // deg2rad below
    var dLon = deg2rad(lonC - lonS);
    var a = sin(dLat / 2) * sin(dLat / 2) +
        cos(deg2rad(latS)) * cos(deg2rad(latC)) * sin(dLon / 2) * sin(dLon / 2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    var d = R * c; // Distance in km
    return d;
  }

  deg2rad(deg) {
    return deg * (3.1415 / 180);
  }
}
