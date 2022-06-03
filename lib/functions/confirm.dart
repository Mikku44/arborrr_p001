// ignore_for_file: file_names, constant_identifier_names
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:arborrr_p001/functions/userInfo.dart';
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
    if (widget.option == 1) {
      return SafeArea(
          child: Scaffold(
        body: Stack(children: [
          const Image(
              image: NetworkImage(
                  'https://images.unsplash.com/photo-1629241290025-6bb716261f5f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80')),
          Container(
              margin: const EdgeInsets.only(top: 70, left: 10),
              child: InkWell(
                  child: Wrap(children: const [
                    Icon(Icons.arrow_back_ios_new_rounded,
                        size: 28, color: Colors.white),
                    Text("ย้อนกลับ",
                        style: TextStyle(fontSize: 18, color: Colors.white))
                  ]),
                  onTap: () {
                    Navigator.pop(context);
                  })),
          Container(
            margin: const EdgeInsets.only(top: 100),
            padding: const EdgeInsets.all(20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'น้ำมันหมด',
                          style: TextStyle(fontSize: 28),
                        ),
                        Column(children: const [
                          Text(
                            'ค่าบริการ',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
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
                              title: const Text("Desel"),
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
                              title: const Text("Gasohol 91"),
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
                              title: const Text("Gasohol 95"),
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
                              title: const Text("E20"),
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
                              title: const Text("E85"),
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
                                        color: Color.fromARGB(
                                            255, 136, 136, 136)))),
                            keyboardType: TextInputType.phone,
                            onChanged: (value) {
                              alert = false;
                              setState(() {});
                            },
                            controller: prices,
                            style: const TextStyle(fontSize: 18),
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
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: Colors.white,
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
    } else {
      return const Scaffold();
    }
  }

  // ignore: non_constant_identifier_names
  CalculateLitre() {
    try {
      String value = prices.text;

      return Text(
        '${(double.parse(value) / _LitrePrices).toStringAsFixed(2)} ลิตร',
        style: const TextStyle(fontSize: 28, color: Colors.black87),
      );
    } catch (e) {
      log('error');
      return const Text(
        '0.00 ลิตร',
        style: TextStyle(fontSize: 28, color: Colors.black87),
      );
    }
  }
}

String error = '';
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
  var currentUser = await getCurrentUser();
  // int timestamp = DateTime.now().millisecondsSinceEpoch;
  // DateTime tsdate = DateTime.fromMillisecondsSinceEpoch(timestamp);
  // String datetime = tsdate.year.toString() +
  //     "/" +
  //     tsdate.month.toString() +
  //     "/" +
  //     tsdate.day.toString();
  db.collection('requestments').add({
    "userID": userID,
    "address": currentUser,
    "Oil": _character.toString(),
    "cost": cost,
    "Payment": 'Not pay yet',
    "RiderID": 'RiderID',
    "Process": 'waiting',
    "timeStamp": Timestamp.now(),
  });
}
