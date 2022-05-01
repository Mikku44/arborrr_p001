import 'package:flutter/material.dart';

// import 'package:shared_preferences/shared_preferences.dart';
const primaryColor = Color(0xFF4059AD);

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          "Payment",
        ),
        elevation: 0,
      ),
      body: Container(),
    );
  }
}
