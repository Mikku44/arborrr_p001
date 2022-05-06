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
