import 'package:flutter/material.dart';
import 'package:arborrr_p001/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

const primaryColor = Color(0xFF4059AD);
String ready = 'ยังไม่พร้อมให้บริการ';
var color = const Color(0xffdc143c);

class Mec extends StatefulWidget {
  const Mec({Key? key}) : super(key: key);

  @override
  State<Mec> createState() => _MecState();
}

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
              child: TextButton(
                  onPressed: () {},
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
                          Text(ready,
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
            card('น้ำมันหมด', '01', context),
            card('ยางแตก', '02', context),
            card('หม้อน้ำแห้ง', '03', context),
            card('สตาร์ทไม่ติด', '04', context),
            card('โซ่ขาด', '05', context),
            card('ยางแบน', '06', context),
            card('บริการยกรถ', '07', context),
          ],
        ),
      ),
    );
  }
}

card(String service, String name, context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Icon(
              Icons.radio_button_unchecked,
              color: Colors.white,
              size: 28,
            ),
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  service,
                  style: const TextStyle(color: Colors.white, fontSize: 32),
                ),
                Text(
                  name,
                  style: const TextStyle(color: Colors.white, fontSize: 96),
                ),
              ])
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0x88000000),
      ),
      height: 210,
    ),
  );
}

serviceCheck() async {
  final prefs = await SharedPreferences.getInstance();
  final double? Km = prefs.getDouble('ClientStay');

  if (Km! <= 15) {
    ready = 'พื้นที่พร้อมให้บริการ';
    color = const Color(0xff97D8C4);
  } else {
    color = const Color(0xffdc143c);
    ready = 'พื้นที่ยังไม่พร้อมให้บริการ';
  }
}
