import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:arborrr_p001/newUser.dart';
import 'package:arborrr_p001/profile.dart';
import 'package:arborrr_p001/Message.dart';
import 'package:arborrr_p001/login.dart';
// import 'package:arborrr_p001/Payment.dart';
import 'package:arborrr_p001/mec.dart';
import 'package:arborrr_p001/mapgl.dart';

const primaryColor = Color(0xFF4059AD);

Future<void> main() async {
  //เชื่อมแอพกับไฟร์เบส
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

//หน้าแรกเริ่มจากแผนที่
int _selectedIndex = 0;

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

//ส่วนหน้าแรกของแอป
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Arborrr Project001a",
      theme: ThemeData(
        scaffoldBackgroundColor: primaryColor,
        fontFamily: 'SukhumvitSet',
      ),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Somthing was wrong!'));
            } else if (snapshot.hasData) {
              return const MyHomePage();
            } else {
              return const Login();
            }
          }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //list ของหน้าโดยการเรียกใช้ฟังก์ชั่นในไฟล์อื่นๆ
  static const List<Widget> _widgetOptions = <Widget>[
    Mec(),
    Message(),
    ViewBox(),
    CreateUser(),
    Profile(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  bool shouldPop = true;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final shouldPop = await warNing(context);
          return shouldPop ?? false;
        },
        child: Scaffold(
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),

          //ส่วนตกแต่งเมนู
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: const Color(0xFF121D22),
            fixedColor: const Color(0xFF97D8C4),
            type: BottomNavigationBarType.fixed,
            // showUnselectedLabels: false,
            // showSelectedLabels: false,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(IconData(0xf1cd, fontFamily: 'awesomefont'),
                      size: 28),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(IconData(0xf1d8, fontFamily: 'awesomefont'),
                      size: 26),
                  label: "Message"),
              BottomNavigationBarItem(
                  icon: Icon(IconData(0xf14e, fontFamily: 'awesomefont'),
                      size: 30),
                  label: "Explore"),
              BottomNavigationBarItem(
                  icon: Icon(IconData(0xe50d, fontFamily: 'MaterialIcons'),
                      size: 28),
                  label: "Payment"),
              BottomNavigationBarItem(
                  icon: Icon(IconData(0xf4fb, fontFamily: 'awesomefont'),
                      size: 28),
                  label: "Profile"),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ));
  }
}
