// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:arborrr_p001/functions/confirm.dart';
import 'package:arborrr_p001/functions/userInfo.dart' as ui;

const primaryColor = Color(0xFF4059AD);

var color = const Color(0xffdc143c);

class Mec extends StatefulWidget {
  const Mec({Key? key}) : super(key: key);

  @override
  State<Mec> createState() => _MecState();
}

bool shouldPop = true;

class _MecState extends State<Mec> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            Image.asset('assets/images/image.png'),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 20, top: 20, right: 210, left: 20),
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
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.fiber_manual_record, color: color),
                          Text(ui.ready,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12))
                        ]),
                  )),
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 50, right: 20, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('ตอนนี้รถคุณมีปัญหาอะไรหรอ?',
                        style: TextStyle(color: Colors.white, fontSize: 24)),
                    Text(
                        'โปรดบอกเรา เพื่อการให้บริการมีประสิทธิภาพ และรวดเร็วขึ้น',
                        style: TextStyle(color: Colors.white, fontSize: 14))
                  ],
                )),
            cardBox(
                'น้ำมันหมด',
                '01',
                'https://images.unsplash.com/photo-1629241290025-6bb716261f5f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
                context,
                1),
            cardBox(
                'รถเสีย',
                '02',
                'https://images.unsplash.com/photo-1619642751034-765dfdf7c58e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80',
                context,
                2),
            cardBox(
                'บริการยกรถ',
                '03',
                'https://images.unsplash.com/photo-1628081182521-d6c4e374357f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1332&q=80',
                context,
                3),
          ],
        ),
      ),
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
cardBox(String text, String number, String url, context, int service) {
  return Container(
      margin: const EdgeInsets.all(5),
      child: Card(
        color: Colors.black,
        elevation: 5,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromARGB(21, 0, 0, 0),
              Color.fromARGB(217, 0, 0, 0)
            ])),
            child: Stack(alignment: AlignmentDirectional.centerEnd, children: [
              Padding(
                padding: const EdgeInsets.only(top: 25, right: 20),
                child: Stack(alignment: AlignmentDirectional.topEnd, children: [
                  Text(
                    text,
                    style: const TextStyle(color: Colors.white, fontSize: 32),
                  ),
                  Text(
                    number,
                    style: const TextStyle(color: Colors.white, fontSize: 96),
                  )
                ]),
              ),
              Ink.image(
                  image: NetworkImage(url),
                  height: 215,
                  fit: BoxFit.cover,
                  child: InkWell(onTap: () {
                    // Navigator.pop(context, true);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Confirm(option: service)));
                  }))
            ])),
      ));
}

//Alert Exit
Future<bool?> warNing(BuildContext context) async => showDialog<bool>(
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
