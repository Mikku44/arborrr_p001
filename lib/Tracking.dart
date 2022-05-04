import 'package:flutter/material.dart';

// import 'package:shared_preferences/shared_preferences.dart';
const primaryColor = Color(0xFF4059AD);

class Tracking extends StatefulWidget {
  const Tracking({Key? key}) : super(key: key);

  @override
  State<Tracking> createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          "Tracking",
        ),
        elevation: 0,
      ),
      body: Container(),
    );
  }
}
