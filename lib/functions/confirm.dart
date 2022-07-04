// ignore_for_file: file_names, constant_identifier_names
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:arborrr_p001/functions/userInfo.dart' as ui;
import 'package:arborrr_p001/map.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'dart:developer';

const primaryColor = Color(0xFF4059AD);
TextEditingController prices = TextEditingController(text: '0');
enum Oil { Desel, G91, G95, E20, E85, Not }
bool alert = false;
var b = Colors.black87;
//connect to firebase
var db = FirebaseFirestore.instance;
String accept = 'ยืนยันคำขอ';

class Confirm extends StatefulWidget {
  final int option;
  const Confirm({
    Key? key,
    required this.option,
  }) : super(key: key);

  @override
  State<Confirm> createState() => _ConfirmState();
}

class _ConfirmState extends State<Confirm> {
  static const List<Widget> _widgetOptions = <Widget>[
    Oilout(),
    OtherManu(),
    Tower(),
  ];

  @override
  Widget build(BuildContext context) {
    return _widgetOptions[widget.option - 1];
  }
}

class Oilout extends StatefulWidget {
  const Oilout({Key? key}) : super(key: key);

  @override
  State<Oilout> createState() => _OiloutState();
}

class _OiloutState extends State<Oilout> {
  List articles = [];
  @override
  void initState() {
    super.initState();

    getOilPrices();
  }
  //Web Scarping

  Future getOilPrices() async {
    final url = Uri.parse('https://www.bangchak.co.th/api/oilprice');
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);

    final titles = html
        .querySelectorAll('body > header > item > today')
        .map((element) => element.innerHtml.trim())
        .toList();

    setState(() {
      articles = List.generate(titles.length, (index) => titles[index]);
    });
  }

  Oil? _character = Oil.Not;
  // ignore: non_constant_identifier_names
  double _LitrePrices = 1;
  setStaete() {}
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: ui.Themecolor,
          title: Text('ทำรายการ', style: TextStyle(color: ui.foreground)),
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child:
                  Icon(Icons.cancel_rounded, color: ui.foreground, size: 32))),
      body: Stack(children: [
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'น้ำมันหมด',
                        style: TextStyle(fontSize: 28, color: ui.foreground),
                      ),
                      Column(children: [
                        Text(
                          'ค่าบริการ',
                          style: TextStyle(fontSize: 16, color: ui.foreground),
                        ),
                        const Text(
                          '฿ +20',
                          style: TextStyle(
                              fontSize: 32, color: Colors.greenAccent),
                        ),
                      ]),
                    ]),
                CalculateLitre(),
                //List Oil Radio Button
                SizedBox(
                    height: 100,
                    child: ListView(
                      itemExtent: 40,
                      padding: const EdgeInsets.only(bottom: 50),
                      children: <Widget>[
                        ListTile(
                            title: Text("Desel",
                                style: TextStyle(color: ui.foreground)),
                            trailing: Radio(
                              value: Oil.Desel,
                              groupValue: _character,
                              onChanged: (Oil? value) {
                                setState(() {
                                  _LitrePrices = double.parse(articles[1]);
                                  _character = value;
                                });
                              },
                            )),
                        ListTile(
                            title: Text("Gasohol 91",
                                style: TextStyle(color: ui.foreground)),
                            trailing: Radio(
                              value: Oil.G91,
                              groupValue: _character,
                              onChanged: (Oil? value) {
                                setState(() {
                                  _LitrePrices = double.parse(articles[6]);
                                  _character = value;
                                });
                              },
                            )),
                        ListTile(
                            title: Text("Gasohol 95",
                                style: TextStyle(color: ui.foreground)),
                            trailing: Radio(
                              value: Oil.G95,
                              groupValue: _character,
                              onChanged: (Oil? value) {
                                setState(() {
                                  _LitrePrices = double.parse(articles[7]);
                                  _character = value;
                                });
                              },
                            )),
                        ListTile(
                            title: Text("E20",
                                style: TextStyle(color: ui.foreground)),
                            trailing: Radio(
                              value: Oil.E20,
                              groupValue: _character,
                              onChanged: (Oil? value) {
                                setState(() {
                                  _LitrePrices = double.parse(articles[5]);
                                  _character = value;
                                });
                              },
                            )),
                        ListTile(
                            title: Text("E85",
                                style: TextStyle(color: ui.foreground)),
                            trailing: Radio(
                              value: Oil.E85,
                              groupValue: _character,
                              onChanged: (Oil? value) {
                                setState(() {
                                  _LitrePrices = double.parse(articles[4]);
                                  _character = value;
                                });
                              },
                            )),
                      ],
                    )),
                Column(
                  children: [
                    SizedBox(
                        width: 100,
                        child: TextField(
                          cursorColor: Colors.black87,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                              isDense: true, // Added this
                              contentPadding: EdgeInsets.all(8),
                              hintText: "ระบุราคาที่ต้องการ",
                              hintStyle: TextStyle(fontSize: 18),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.greenAccent)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 136, 136, 136)))),
                          keyboardType: TextInputType.phone,
                          onChanged: (value) {
                            alert = false;
                            setState(() {});
                          },
                          controller: prices,
                          style: TextStyle(fontSize: 18, color: ui.foreground),
                        )),
                  ],
                ),
                TextButton(
                  onPressed: () async {
                    Uri url = Uri.parse(
                        'https://www.bangchak.co.th/en/oilprice/widget');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url,
                          mode: LaunchMode.externalNonBrowserApplication);
                    } else {
                      log('Could not launch $url');
                    }
                  },
                  child: const Text('ดูราคาน้ำมันวันนี้'),
                ),
                SizedBox(
                    height: 54,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: b),
                      onPressed: () {
                        if (accept != 'ยืนยันคำขอแล้ว') {
                          try {
                            // use to collect data to firestore
                            var old = double.parse(prices.text);
                            collectRequest(old, _character);
                          } catch (e) {
                            log("can't collect");
                          }
                          setState(() {});
                        }
                      },
                      child: Text(accept),
                    ))
              ]),
          decoration: BoxDecoration(
            color: ui.Themecolor,
          ),
          width: MediaQuery.of(context).size.width,
        ),
        Visibility(
          visible: alert,
          child: Padding(
            padding: const EdgeInsets.only(top: 100, left: 15),
            child: Card(
                color: Colors.redAccent,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  width: 360,
                  height: 100,
                  child: Text("ไม่สามารถทำรายการได้ $error",
                      style:
                          const TextStyle(fontSize: 18, color: Colors.white)),
                )),
          ),
        )
      ]),
    ));
  }

  // ignore: non_constant_identifier_names
  CalculateLitre() {
    try {
      String value = prices.text;

      return Text(
        '${(double.parse(value) / _LitrePrices).toStringAsFixed(2)} ลิตร',
        style: TextStyle(fontSize: 28, color: ui.foreground),
      );
    } catch (e) {
      log('error');
      return Text(
        '0.00 ลิตร',
        style: TextStyle(fontSize: 28, color: ui.foreground),
      );
    }
  }
}

String error = '';

class OtherManu extends StatefulWidget {
  const OtherManu({Key? key}) : super(key: key);

  @override
  State<OtherManu> createState() => _OtherManuState();
}

bool collected = false;
TextEditingController problem = TextEditingController();
TextEditingController modelCar = TextEditingController();

class _OtherManuState extends State<OtherManu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: ui.Themecolor,
            title: Text('ทำรายการ', style: TextStyle(color: ui.foreground)),
            leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.cancel_rounded,
                    color: ui.foreground, size: 32))),
        body: Stack(
          children: [
            Container(color: ui.Themecolor),
            const SizedBox(height: 415, child: MapPage()),
            Column(children: [
              const Expanded(
                flex: 12,
                child: SizedBox(),
              ),
              Expanded(
                  flex: 11,
                  child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Stack(children: [
                        Visibility(
                          visible: !collected,
                          child: Wrap(
                            // direction: Axis.vertical,
                            runSpacing: 10,
                            children: [
                              Text('รถของคุณยี่ห้ออะไร?',
                                  style: TextStyle(
                                      color: ui.foreground, fontSize: 18)),
                              inputField(modelCar),
                              Text('ระบุอาการเบื้องต้น?',
                                  style: TextStyle(
                                      color: ui.foreground, fontSize: 18)),
                              inputField(problem),
                              Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: SizedBox(
                                      width: double.infinity,
                                      height: 54,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: b),
                                        child: const Text('บอกช่างเลย'),
                                        onPressed: () {
                                          collectRequestOther();

                                          setState(() {});
                                        },
                                      )))
                            ],
                          ),
                        ),
                        Visibility(
                            visible: collected,
                            child: Center(
                                child: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    direction: Axis.vertical,
                                    children: [
                                  const Icon(Icons.draw_outlined,
                                      size: 96, color: Colors.greenAccent),
                                  const Text('ติดต่อช่างสำเร็จ',
                                      style: TextStyle(
                                          color: Colors.greenAccent,
                                          fontSize: 18)),
                                  backBtn(context)
                                ])))
                      ]),
                      decoration: BoxDecoration(
                          color: ui.Themecolor,
                          borderRadius: BorderRadius.circular(20))))
            ])
          ],
        ));
  }
}

Widget inputField(_controller) {
  return TextField(
    controller: _controller,
    cursorColor: ui.foreground,
    style: TextStyle(
      color: ui.foreground,
      fontSize: 16.0,
    ),
    decoration: InputDecoration(
      isDense: true, // Added this
      contentPadding: const EdgeInsets.all(8),
      filled: true,
      fillColor: ui.onPrimary,
      focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff4059ad))),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ui.foregroundHead),
      ),
    ),
  );
}

class Tower extends StatefulWidget {
  const Tower({Key? key}) : super(key: key);

  @override
  State<Tower> createState() => _TowerState();
}

class _TowerState extends State<Tower> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance
            .collection('requestments')
            .doc(ui.userID)
            .get(),
        builder: (_, snapshot) {
          if (snapshot.hasError) return Text('Error = ${snapshot.error}');
          if (snapshot.hasData) {
            var data = snapshot.data!.data();
            log("$data");
            if (data?['Process'] == 'waiting') {
              collected = true;
            } else {
              collected = false;
            } // if process is success back to simple menu
          }
          return Scaffold(
              appBar: AppBar(
                  elevation: 0,
                  centerTitle: true,
                  backgroundColor: ui.Themecolor,
                  title:
                      Text('ทำรายการ', style: TextStyle(color: ui.foreground)),
                  leading: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.cancel_rounded,
                          color: ui.foreground, size: 32))),
              body: Stack(
                children: [
                  const SizedBox(height: 415, child: MapPage()),
                  Column(
                    children: [
                      const Expanded(flex: 12, child: SizedBox()),
                      Expanded(
                        flex: 11,
                        child: Container(
                            padding: const EdgeInsets.all(30),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: ui.Themecolor,
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20))),
                            child: Stack(
                              children: [
                                Visibility(
                                  visible: !collected,
                                  child: Wrap(runSpacing: 120, children: [
                                    Text('ต้องการใช่บริการรถยกใช่ไหม?',
                                        style: TextStyle(
                                            color: ui.foreground,
                                            fontSize: 18)),
                                    SizedBox(
                                      height: 54,
                                      width: double.infinity,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: b),
                                          onPressed: () {
                                            towerRequest();
                                            setState(() {});
                                          },
                                          child: const Text('Send')),
                                    )
                                  ]),
                                ),
                                Visibility(
                                    visible: collected,
                                    child: Center(
                                        child: Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            direction: Axis.vertical,
                                            children: [
                                          const Icon(Icons.draw_outlined,
                                              size: 96,
                                              color: Colors.greenAccent),
                                          const Text('ติดต่อสำเร็จ',
                                              style: TextStyle(
                                                  color: Colors.greenAccent,
                                                  fontSize: 18)),
                                          backBtn(context)
                                        ])))
                              ],
                            )),
                      ),
                    ],
                  ),
                ],
              ));
        });
  }
}

collectRequest(cost, _character) async {
  if (_character == Oil.Not) {
    log('Please select oil type');
    error = "โปรดเลือกประเภทน้ำมันอย่างใด อย่างหนึ่ง";
    alert = true;
    return;
  }
  if (cost < 30) {
    log('Please enter more than 30 baht');
    error = 'โปรดระบุราคาขั้นต่ำ 30 บาท';
    alert = true;
    return;
  }
  accept = 'ยืนยันคำขอแล้ว';
  b = Colors.black12;
  var currentUser = await ui.getCurrentUser();
  await db.collection('requestments').doc(ui.userID).set({
    "title": 'OutOfFuel',
    "userID": ui.userID,
    "address": currentUser,
    "Oil": _character.toString(),
    "cost": cost,
    "Payment": 'Not pay yet',
    "RiderID": 'RiderID',
    "Process": 'waiting',
    "timeStamp": Timestamp.now(),
  });
}

collectRequestOther() async {
  if (modelCar.text == '') {
    log('Error');
    return;
  }
  collected = true;
  var currentUser = await ui.getCurrentUser();

  await db.collection('requestments').doc(ui.userID).set({
    "title": 'CarCrash',
    "userID": ui.userID,
    "address": currentUser,
    "Model Car": modelCar.text,
    "cost": 'cost',
    "Problem": problem.text,
    "Payment": 'Not pay yet',
    "FixID": 'FixID',
    "Process": 'waiting',
    "timeStamp": Timestamp.now(),
  });
}

towerRequest() async {
  collected = true;
  var currentUser = await ui.getCurrentUser();

  await db.collection('requestments').doc(ui.userID).set({
    "title": 'Tower',
    "userID": ui.userID,
    "address": currentUser,
    "cost": 'cost',
    "Payment": 'Not pay yet',
    "FixID": 'FixID',
    "Process": 'waiting',
    "timeStamp": Timestamp.now(),
  });
}

backBtn(context) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: b),
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text('กลับสู่หน้าหลัก'));
}
