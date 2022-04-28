import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

//ส่วนต่างๆในแอป
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Arborrr Project001a",
      theme: ThemeData(
        fontFamily: 'SukhumvitSet',
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4059AD),
      appBar: AppBar(
        title: Text('Arborrr'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(""),
            Text(""),
            Text(
              "LOGO",
              style: TextStyle(fontSize: 64, color: Colors.white),
            ),
            Text(''),
            Text(''),
            Text(
              "Arborrr",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
