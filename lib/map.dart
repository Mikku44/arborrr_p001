import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import 'package:geolocator/geolocator.dart';

var latLngValue = LatLng(7, 80);
// var latLngValue = getLatLng() as LatLng;

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final String apiKey =
      "pk.eyJ1IjoiYW5kYWxhbmd1IiwiYSI6ImNsMnVlOWRlNjAxNjgzY3Jxb2hvb2xidTMifQ.K3sCVYf7NoKNBaCWa9qFlA";
  var icon = const Icon(Icons.location_searching);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            FlutterMap(
              options: MapOptions(center: latLngValue, zoom: 16.0),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      "https://api.mapbox.com/styles/v1/andalangu/cl2ueg701000w14pobkyikmta/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYW5kYWxhbmd1IiwiYSI6ImNsMnVlOWRlNjAxNjgzY3Jxb2hvb2xidTMifQ.K3sCVYf7NoKNBaCWa9qFlA",
                  additionalOptions: {
                    "accessToken": apiKey,
                    'id': 'mapbox.satellite'
                  },
                  attributionBuilder: (_) {
                    return const Text("© OpenStreetMap contributors ,© Mapbox",
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
              margin: const EdgeInsets.only(bottom: 55),
              padding: const EdgeInsets.all(30),
              alignment: Alignment.bottomLeft,
              width: 150,
              child: Image.asset("assets/images/Mapbox_logo.png"),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 60),
          child: FloatingActionButton(
              backgroundColor: const Color(0xff091122),
              elevation: 2,
              child: icon,
              onPressed: () async {
                Position position = await _determinePosition();
                latLngValue = LatLng(position.latitude, position.longitude);
                icon = const Icon(Icons.my_location);

                setState(() {});
              })),
    );
  }
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
  return position;
}
