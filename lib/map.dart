import 'package:arborrr_p001/main.dart';
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import 'package:geolocator/geolocator.dart';
import "package:http/http.dart" as http;
import "dart:convert" as convert;
import 'dart:developer';

LatLng latLngValue = getLatLng() as LatLng ?? LatLng(7, 80);

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final String apiKey =
      "pk.eyJ1IjoiYW5kYWxhbmd1IiwiYSI6ImNsMnVlOWRlNjAxNjgzY3Jxb2hvb2xidTMifQ.K3sCVYf7NoKNBaCWa9qFlA";

  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MapBox",
      home: Scaffold(
        appBar: AppBar(
          title: Text('Explore'),
          backgroundColor: primaryColor,
          elevation: 0,
        ),
        body: Center(
          child: Stack(
            children: <Widget>[
              FlutterMap(
                options: MapOptions(center: latLngValue, zoom: 16.0),
                layers: [
                  TileLayerOptions(
                    fastReplace: true,
                    urlTemplate:
                        "https://api.mapbox.com/styles/v1/andalangu/cl2ueg701000w14pobkyikmta/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYW5kYWxhbmd1IiwiYSI6ImNsMnVlOWRlNjAxNjgzY3Jxb2hvb2xidTMifQ.K3sCVYf7NoKNBaCWa9qFlA",
                    additionalOptions: {
                      "accessToken": apiKey,
                      'id': 'mapbox.satellite'
                    },
                    attributionBuilder: (_) {
                      return Text("© OpenStreetMap contributors ,© Mapbox",
                          style: TextStyle(fontSize: 10, color: Colors.white));
                    },
                  ),
                  MarkerLayerOptions(
                    markers: [
                      Marker(
                        rotate: true,
                        width: 80.0,
                        height: 80.0,
                        point: latLngValue,
                        builder: (BuildContext context) => const Icon(
                            IconData(0xf3c5, fontFamily: 'awesomefont'),
                            size: 45.0,
                            color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.bottomLeft,
                width: 150,
                child: Image.asset("assets/images/Mapbox_logo.png"),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: primaryColor,
            elevation: 2,
            child: const Icon(Icons.my_location),
            onPressed: () async {
              Position position = await _determinePosition();
              latLngValue = LatLng(position.latitude, position.longitude);

              log('${LatLng(position.latitude, position.longitude)}');
              setState(() {});
            }),
      ),
    );
  }
}

Future getLatLng() async {
  var latLngValue = await _determinePosition();
  return latLngValue;
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();

  if (!serviceEnabled) {
    return Future.error('Location services are disabled');
  }

  permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      return Future.error("Location permission denied");
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error('Location permissions are permanently denied');
  }

  Position position = await Geolocator.getCurrentPosition();
  latLngValue = LatLng(position.latitude, position.longitude);
  return position;
}
