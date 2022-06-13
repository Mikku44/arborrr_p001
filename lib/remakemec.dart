// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:arborrr_p001/functions/userInfo.dart' as ui;
import 'package:arborrr_p001/functions/confirm.dart';

const primaryColor = Color(0xFF4059AD);

var color = const Color(0xffdc143c);

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

bool shouldPop = true;

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Wrap(children: [
        Image.asset('assets/images/image.png'),
        Padding(
          padding: const EdgeInsets.only(top: 20, right: 210, left: 20),
          child: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => const AlertDialog(
                          content: Text(
                              'หากยังไม่ได้ยืนยันตำแหน่งให้ไปที่หน้า Explore แล้วกดปุ่ม "ยืนยันตำแหน่ง"'),
                          title: Text('แถบสถานะการให้บริการ'),
                        ));
              },
              child: Container(
                height: 25,
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(5),
                ),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(Icons.fiber_manual_record, color: color),
                  Text(ui.ready,
                      style: const TextStyle(color: Colors.white, fontSize: 12))
                ]),
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10, right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('ตอนนี้รถคุณมีปัญหาอะไรหรอ?',
                  style: TextStyle(color: Colors.white, fontSize: 24)),
              Text('โปรดบอกเรา เพื่อการให้บริการมีประสิทธิภาพ และรวดเร็วขึ้น',
                  style: TextStyle(color: Colors.white, fontSize: 14))
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          height: 350,
          width: double.infinity,
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  BoxMenu('01', 'Out of fuel', context, 1),
                  BoxMenu('02', 'Car crash', context, 2),
                  BoxMenu('03', 'Car Service', context, 3),
                ],
              )),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(30)),
            color: ui.Themecolor,
          ),
        )
      ]),
    );
  }
}

// Back-end Part Distance check for service
serviceCheck() async {
  final prefs = await SharedPreferences.getInstance();
  final double? Km = prefs.getDouble('ClientStay');

  if (Km! <= 15) {
    ui.ready = 'พื้นที่พร้อมให้บริการ';
    color = const Color(0xff97D8C4);
  } else {
    color = const Color(0xffdc143c);
    ui.ready = 'พื้นที่ยังไม่พร้อมให้บริการ';
  }
}

//UI Part
//card function
BoxMenu(number, text, context, service) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: ui.Themecolor,
          onPrimary: ui.foreground,
          shadowColor: ui.foreground,
          elevation: 40,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      child: Container(
          padding: const EdgeInsets.only(bottom: 20),
          height: 300,
          width: 170,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Image(
                image: NetworkImage(
                    'https://img.freepik.com/free-vector/team-construction-workers-with-wind-turbines-solar-panels-installation-repair-electric-utility-poles-flat-vector-illustration-maintenance-service-electricity-renewable-energy-concept_74855-23179.jpg?t=st=1654801718~exp=1654802318~hmac=72b2aee28a0c088ae3f20908edea64ec9d131d842e556c523dc9e7f2d8e5a93f&w=1060'),
                height: 215,
                fit: BoxFit.cover,
              ),
              Wrap(
                spacing: 10,
                children: [
                  Text(number,
                      style: TextStyle(color: ui.foreground, fontSize: 18)),
                  Text(text,
                      style: TextStyle(color: ui.foreground, fontSize: 18)),
                ],
              ),
            ],
          )),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Confirm(option: service)));
      },
    ),
  );
}

//Alert Exit
Future<bool?> ExitAlert(BuildContext context) async => showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
          title: const Text("คุณต้องการปิดแอพหรือไหม?",
              style: TextStyle(color: Colors.white)),
          content: const Text("กดยืนยันเพื่อปิดแอพลิเคชั่นตอนนี้",
              style: TextStyle(color: Colors.white)),
          backgroundColor: const Color(0xFF252525),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(
                  primary: Colors.white, onPrimary: Colors.red),
              child: const Text(
                "Yes",
                style: TextStyle(color: Color.fromARGB(255, 255, 58, 58)),
              ),
            ),
            TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text(
                  "No",
                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                ))
          ],
        ));
