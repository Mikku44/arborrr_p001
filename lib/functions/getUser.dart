// ignore_for_file: unused_import, file_names

import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:arborrr_p001/login.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'dart:developer';

var db = FirebaseFirestore.instance;
//connect to collection users
var x = db.collection('users').doc(user.uid);
//for webinfo
List articles = ['hello'];

// Profile Page
class StoreUser extends StatefulWidget {
  const StoreUser({Key? key}) : super(key: key);

  @override
  State<StoreUser> createState() => _StoreUserState();
}

class _StoreUserState extends State<StoreUser> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: x.get(),
      builder: (_, snapshot) {
        if (snapshot.hasError) return Text('Error = ${snapshot.error}');

        if (snapshot.hasData) {
          var data = snapshot.data!.data();
          List value = [
            data!['first'],
            data['last'],
            data['phone'],
            data['email'],
            data['pic'],
          ];

          return Scaffold(
            body: ListView(children: [
              //Account
              Stack(children: [
                Container(
                  margin: const EdgeInsets.only(top: 150),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        topLeft: Radius.circular(20.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        Column(children: [
                          const SizedBox(
                            height: 90,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('${value[0]} ${value[1]}',
                                      style: const TextStyle(fontSize: 32)),
                                  Text('Phone ${value[2]}',
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.black38)),
                                  Text('UID : ${user.uid}',
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.black38)),
                                  SizedBox(
                                      width: 135,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                                  primary: Colors.blueAccent,
                                                  elevation: 0,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)))
                                              .copyWith(
                                                  elevation: ButtonStyleButton
                                                      .allOrNull(0.0)),
                                          onPressed: () {},
                                          child: Row(children: const [
                                            Text('แก้ไขโปรไฟล์',
                                                style: TextStyle(fontSize: 16)),
                                            Icon(Icons
                                                .keyboard_arrow_right_rounded)
                                          ]))),
                                ]),
                          )
                        ]),

                        Wrap(
                          direction: Axis.vertical,
                          children: [
                            //Help & Feedback
                            Container(
                              width: 150,
                              padding: const EdgeInsets.all(5),
                              child: Row(children: const [
                                Icon(Icons.support, color: Colors.black38),
                                Text(' Help & Feedback ',
                                    style: TextStyle(color: Colors.black38)),
                              ]),
                            ),

                            subList(
                                context,
                                'ศูนย์ช่วยเหลือ',
                                const WebManu(
                                  url:
                                      'https://policies.google.com/privacy?hl=th&fg=1',
                                  name: 'ศูนย์ช่วยเหลือ',
                                )),
                            subList(
                                context,
                                'ข้อเสนอแนะ & ความคิดเห็น',
                                const WebManu(
                                  url:
                                      'https://policies.google.com/privacy?hl=th&fg=1',
                                  name: 'ข้อเสนอแนะ',
                                )),
                            subList(
                                context,
                                'Terms & Policies',
                                const WebManu(
                                  url:
                                      'https://policies.google.com/privacy?hl=th&fg=1',
                                  name: 'Privacy Policy',
                                )),
                          ],
                        ),
                        //Help & Feedback
                        Wrap(
                          direction: Axis.vertical,
                          spacing: 20,
                          children: [
                            Container(
                              width: 100,
                              padding: const EdgeInsets.all(5),
                              child: Row(children: const [
                                Icon(Icons.settings, color: Colors.black38),
                                Text(' General ',
                                    style: TextStyle(color: Colors.black38)),
                              ]),
                            ),
                            subList(context, 'การแจ้งเตือน', null),
                            subList(context, 'ธีมรูปลักษณ์', null),
                          ],
                        ),

                        const SizedBox(
                            height: 20, child: Text('  ')), //Logout Button

                        SizedBox(
                          height: 54,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                              child: const Text(
                                'ลงชื่อออก',
                              ),
                              onPressed: () async {
                                await auth.signOut();
                              },
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  primary:
                                      const Color.fromARGB(255, 223, 30, 69),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(14)))),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Center(
                        child: CircleAvatar(
                            radius: 100,
                            backgroundImage: NetworkImage('${value[4]}')))),
              ])
            ]),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

//Submanu in Profile
class WebManu extends StatefulWidget {
  final String name, url;
  const WebManu({Key? key, required this.url, required this.name})
      : super(key: key);

  @override
  State<WebManu> createState() => _WebManuState();
}

class _WebManuState extends State<WebManu> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
          child: Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: Container(
            color: const Color(0xff121212),
            child: Scrollbar(
                thickness: 10,
                isAlwaysShown: true,
                interactive: true,
                showTrackOnHover: true,
                child: WebView(
                  initialUrl: widget.url,
                ))),
      ));
}

subList(context, title, pagerout) {
  return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ListTile(
          title: Text(title),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: ((context) => pagerout)));
          }));
}
