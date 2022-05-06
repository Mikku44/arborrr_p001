import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// import 'package:arborrr_p001/login.dart';
// import 'package:arborrr_p001/profile.dart';
// import 'package:arborrr_p001/Message.dart';
import 'package:arborrr_p001/Payment.dart';
import 'package:arborrr_p001/mec.dart';
import 'package:arborrr_p001/map.dart';
import "package:latlong2/latlong.dart";

const primaryColor = Color(0xFF4059AD);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Mec(),
    Text(
      'Index 3: Message',
    ),
    MapPage(),
    Payment(),
    Text(
      'Index 5: Profile',
    ),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF121D22),
        fixedColor: const Color(0xFF97D8C4),
        type: BottomNavigationBarType.fixed,
        // showUnselectedLabels: false,
        // showSelectedLabels: false,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(IconData(0xf1cd, fontFamily: 'awesomefont'), size: 28),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(IconData(0xf1d8, fontFamily: 'awesomefont'), size: 26),
              label: "Message"),
          BottomNavigationBarItem(
              icon: Icon(IconData(0xf14e, fontFamily: 'awesomefont'), size: 30),
              label: "Explore"),
          BottomNavigationBarItem(
              icon:
                  Icon(IconData(0xe50d, fontFamily: 'MaterialIcons'), size: 28),
              label: "Payment"),
          BottomNavigationBarItem(
              icon: Icon(IconData(0xf4fb, fontFamily: 'awesomefont'), size: 28),
              label: "Profile"),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
