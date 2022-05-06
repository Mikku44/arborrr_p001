import 'package:arborrr_p001/main.dart';
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import 'package:geolocator/geolocator.dart';
import 'package:arborrr_p001/copyrights_page.dart';
import "package:http/http.dart" as http;
import "dart:convert" as convert;
import 'dart:developer';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

var tomtomHQ = LatLng(7.95357, 7.95357);

class _MapPageState extends State<MapPage> {
  final String apiKey = "SovU5lE0pXkNfdGu3GajCF2wT38B8lVj";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TomTom Map",
      home: Scaffold(
        appBar: AppBar(
          title: Text('Explore'),
          backgroundColor: primaryColor,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () async {
                  http.Response response = await getCopyrightsJSONResponse();

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CopyrightsPage(
                              copyrightsText:
                                  parseCopyrightsResponse(response))));
                },
                icon: Icon(Icons.copyright))
          ],
        ),
        body: Center(
          child: Stack(
            children: <Widget>[
              FlutterMap(
                options: MapOptions(center: tomtomHQ, zoom: 18.0),
                layers: [
                  TileLayerOptions(
                    fastReplace: true,
                    urlTemplate: "https://api.tomtom.com/map/1/tile/basic/main/"
                        "{z}/{x}/{y}.png?key={apiKey}",
                    additionalOptions: {"apiKey": apiKey},
                  ),
                  MarkerLayerOptions(
                    markers: [
                      Marker(
                        rotate: true,
                        width: 80.0,
                        height: 80.0,
                        point: tomtomHQ,
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
                child: Image.asset("assets/images/tt_logo.png"),
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
              tomtomHQ = LatLng(position.latitude, position.longitude);

              log('${LatLng(position.latitude, position.longitude)}');
              setState(() {});
            }),
      ),
    );
  }

  Future<http.Response> getCopyrightsJSONResponse() async {
    var url =
        Uri.parse("https://api.tomtom.com/map/1/copyrights.json?key=$apiKey");
    var response = await http.get(url);
    return response;
  }

  String parseCopyrightsResponse(http.Response response) {
    if (response.statusCode == 200) {
      StringBuffer stringBuffer = StringBuffer();
      var jsonResponse = convert.jsonDecode(response.body);
      parseGeneralCopyrights(jsonResponse, stringBuffer);
      parseRegionsCopyrights(jsonResponse, stringBuffer);
      return stringBuffer.toString();
    }
    return "Can't get copyrights";
  }

  void parseRegionsCopyrights(jsonResponse, StringBuffer sb) {
    List<dynamic> copyrightsRegions = jsonResponse["regions"];
    for (var element in copyrightsRegions) {
      sb.writeln(element["country"]["label"]);
      List<dynamic> cpy = element["copyrights"];
      for (var e in cpy) {
        sb.writeln(e);
      }
      sb.writeln("");
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

  void parseGeneralCopyrights(jsonResponse, StringBuffer sb) {
    List<dynamic> generalCopyrights = jsonResponse["generalCopyrights"];
    for (var element in generalCopyrights) {
      sb.writeln(element);
      sb.writeln("");
    }
    sb.writeln("");
  }
}
