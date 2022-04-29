import 'package:flutter/material.dart';
import 'package:arborrr_p001/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;

  runApp(MyApp(showHome: showHome));
}

//ส่วนต่างๆในแอป
class MyApp extends StatelessWidget {
  final bool showHome;
  const MyApp({
    Key? key,
    required this.showHome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Arborrr Project001a",
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF4059AD),
        fontFamily: 'SukhumvitSet',
        primarySwatch: Colors.blue,
      ),
      home: showHome ? const MyHomePage() : const Login(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  final String title = 'Arborrr';
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: TabBarView(
          children: [
            Container(),
            Container(),
            Container(),
            Container(),
          ],
        ),
        backgroundColor: Colors.blue,
        bottomNavigationBar: const TabBar(
          tabs: [
            Tab(
              text: 'Mec',
            ),
            Tab(
              text: 'Message',
            ),
            Tab(
              text: 'Payment',
            ),
            Tab(
              text: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
