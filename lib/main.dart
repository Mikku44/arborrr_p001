import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:arborrr_p001/login.dart';
import 'package:arborrr_p001/profile.dart';
import 'package:arborrr_p001/Message.dart';
import 'package:arborrr_p001/Payment.dart';
import 'package:arborrr_p001/mec.dart';

const primaryColor = Color(0xFF4059AD);
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
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
        scaffoldBackgroundColor: primaryColor,
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
    return const DefaultTabController(
      length: 4,
      child: Scaffold(
        body: TabBarView(
          children: [
            Mec(),
            Message(),
            Payment(),
            Profile(),
          ],
        ),
        backgroundColor: Color(0xFF121D22),
        bottomNavigationBar: TabBar(
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
