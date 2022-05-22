// ignore_for_file: file_names, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:developer';

const primaryColor = Color(0xFF4059AD);
TextEditingController prices = TextEditingController(text: '0');
enum Oil { Desel, G91, G95, E20, E85 }

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
  var _character;
  setStaete() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Expanded(
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
                Text(
                  '${(int.parse(prices.text) / _character).toStringAsFixed(2)} ลิตร',
                  style: const TextStyle(fontSize: 28, color: Colors.black87),
                ),
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
                              value: 31.94,
                              groupValue: _character,
                              onChanged: (value) {
                                setState(() {
                                  _character = value;
                                });
                              },
                            )),
                        ListTile(
                            title: const Text("Gasohol 91"),
                            trailing: Radio(
                              value: 42.68,
                              groupValue: _character,
                              onChanged: (value) {
                                setState(() {
                                  _character = value;
                                });
                              },
                            )),
                        ListTile(
                            title: const Text("Gasohol 95"),
                            trailing: Radio(
                              value: 42.95,
                              groupValue: _character,
                              onChanged: (value) {
                                setState(() {
                                  _character = value;
                                });
                              },
                            )),
                        ListTile(
                            title: const Text("E20"),
                            trailing: Radio(
                              value: 41.84,
                              groupValue: _character,
                              onChanged: (value) {
                                setState(() {
                                  _character = value;
                                });
                              },
                            )),
                        ListTile(
                            title: const Text("E85"),
                            trailing: Radio(
                              value: 35.84,
                              groupValue: _character,
                              onChanged: (value) {
                                setState(() {
                                  _character = value;
                                });
                              },
                            )),
                      ],
                    )),
                Column(
                  children: [
                    SizedBox(
                        width: 250,
                        child: TextField(
                          cursorColor: Colors.black87,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
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
                          controller: prices,
                          style: const TextStyle(fontSize: 18),
                        )),
                  ],
                ),
                TextButton(
                  onPressed: () async {
                    Uri url = Uri.parse(
                        'https://www.bangchak.co.th/en/oilprice/widget');
                    if (!await launchUrl(url)) {
                      log('Could not launch $url');
                    }
                  },
                  child: const Text('ดูราคาน้ำมันวันนี้'),
                ),
                SizedBox(
                    height: 54,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.black87),
                      onPressed: () {},
                      child: const Text('ยืนยันคำสั่งซื้อ'),
                    ))
              ])),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: Colors.white,
          ),
          width: MediaQuery.of(context).size.width,
        )
      ]),
    );
  }
}
