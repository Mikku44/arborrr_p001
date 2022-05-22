// ignore_for_file: file_names

import 'package:flutter/material.dart'
    show
        AppBar,
        BorderRadius,
        BoxDecoration,
        BuildContext,
        Color,
        Colors,
        Container,
        Key,
        Scaffold,
        State,
        StatefulWidget,
        Text,
        Widget;

const primaryColor = Color(0xFF4059AD);

class Confirm extends StatefulWidget {
  const Confirm({Key? key}) : super(key: key);

  @override
  State<Confirm> createState() => _ConfirmState();
}

class _ConfirmState extends State<Confirm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          "Confirm",
        ),
        elevation: 0,
      ),
      body: Container(
        child: const Text(
          'This is a Container',
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        height: 200,
      ),
    );
  }
}
