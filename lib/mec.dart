import 'package:flutter/material.dart';
import 'package:arborrr_p001/var.dart';
// import 'package:shared_preferences/shared_preferences.dart';

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
