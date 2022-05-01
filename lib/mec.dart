import 'package:flutter/material.dart';

// import 'package:shared_preferences/shared_preferences.dart';
const primaryColor = Color(0xFF4059AD);

class Mec extends StatefulWidget {
  const Mec({Key? key}) : super(key: key);

  @override
  State<Mec> createState() => _MecState();
}

class _MecState extends State<Mec> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          "Call",
        ),
        elevation: 0,
      ),
      body: Container(),
    );
  }
}
