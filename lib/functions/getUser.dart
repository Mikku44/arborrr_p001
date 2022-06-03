// ignore_for_file: unused_import, file_names, unrelated_type_equality_checks

import 'dart:convert';
import 'dart:io';

import 'package:arborrr_p001/functions/userInfo.dart' as ui;
import 'package:arborrr_p001/mec.dart';
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
          subList(context, title, pagerout) {
            return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ListTile(
                    title: Text(title, style: TextStyle(color: ui.foreground)),
                    onTap: () async {
                      await Navigator.push(context,
                          MaterialPageRoute(builder: ((context) => pagerout)));
                      setState(() {});
                    }));
          }

          return Scaffold(
            body: ListView(children: [
              //Account
              Stack(children: [
                Container(
                  margin: const EdgeInsets.only(top: 150),
                  decoration: BoxDecoration(
                    color: ui.Themecolor,
                    borderRadius: const BorderRadius.only(
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
                                      style: TextStyle(
                                          fontSize: 32, color: ui.foreground)),
                                  Text('Phone ${value[2]}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: ui.foregroundHead)),
                                  Text('UID : ${user.uid}',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: ui.foregroundHead)),
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
                                          onPressed: () async {
                                            await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const EditInfo(),
                                                ));
                                            setState(() {});
                                          },
                                          child: Row(children: const [
                                            Text('แก้ไขโปรไฟล์',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white)),
                                            Icon(
                                                Icons
                                                    .keyboard_arrow_right_rounded,
                                                color: Colors.white)
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
                              child: Row(children: [
                                Icon(Icons.support, color: ui.foregroundHead),
                                Text(' Help & Feedback ',
                                    style: TextStyle(color: ui.foregroundHead)),
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
                              child: Row(children: [
                                Icon(Icons.settings, color: ui.foregroundHead),
                                Text(' General ',
                                    style: TextStyle(color: ui.foregroundHead)),
                              ]),
                            ),
                            subList(context, 'การแจ้งเตือน', const NoticeSet()),
                            subList(
                                context, 'ธีมรูปลักษณ์', const ThemeDefault()),
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

//notification page
class NoticeSet extends StatefulWidget {
  const NoticeSet({Key? key}) : super(key: key);

  @override
  State<NoticeSet> createState() => _NoticeSetState();
}

class _NoticeSetState extends State<NoticeSet> {
  bool openNotice = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ui.Themecolor,
        appBar: AppBar(
            title: const Text('การแจ้งเตือน'), backgroundColor: Colors.black),
        body: SwitchListTile(
          title: Text("เปิดการแจ้งเตือนเสมอ",
              style: TextStyle(color: ui.foreground)),
          value: openNotice,
          onChanged: (bool value) {
            setState(() {
              openNotice = value;
            });
          },
        ),
      ),
    );
  }
}

class ThemeDefault extends StatefulWidget {
  const ThemeDefault({Key? key}) : super(key: key);

  @override
  State<ThemeDefault> createState() => _ThemeDefaultState();
}

class _ThemeDefaultState extends State<ThemeDefault> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ui.Themecolor,
        appBar: AppBar(
            leading: InkWell(
                child: const Icon(Icons.arrow_back_rounded),
                onTap: () {
                  Navigator.of(context).pop();
                }),
            title: const Text('ธีมรูปลักษณ์'),
            backgroundColor: Colors.black),
        body: ListView(children: [
          RadioListTile(
            title: Text('Dark Theme', style: TextStyle(color: ui.foreground)),
            value: ui.Theme.dark,
            groupValue: ui.selectedTheme,
            onChanged: (ui.Theme? value) {
              setState(() {
                ui.selectedTheme = value;
                ui.Themecolor = const Color(0xff121212);
                ui.foreground = const Color(0xfff2f2f2);
                ui.foregroundHead = const Color(0xff888888);
              });
            },
          ),
          RadioListTile(
            title: Text('Light Theme', style: TextStyle(color: ui.foreground)),
            value: ui.Theme.normal,
            groupValue: ui.selectedTheme,
            onChanged: (ui.Theme? value) {
              setState(() {
                ui.selectedTheme = value;
                ui.Themecolor = Colors.white;
                ui.foreground = Colors.black87;
                ui.foregroundHead = Colors.black38;
              });
            },
          )
        ]),
      ),
    );
  }
}

class EditInfo extends StatefulWidget {
  const EditInfo({Key? key}) : super(key: key);

  @override
  State<EditInfo> createState() => _EditInfoState();
}

class _EditInfoState extends State<EditInfo> {
  TextEditingController name = TextEditingController();
  TextEditingController lastname = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ui.Themecolor,
      appBar: AppBar(
        title: const Text('แก้ไขโปรไฟล์'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Wrap(
            runSpacing: 10,
            children: [
              Text('Name', style: TextStyle(color: ui.foreground)),
              inputField(name),
              Text('Last name', style: TextStyle(color: ui.foreground)),
              inputField(lastname),
            ],
          )),
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xff4059ad),
          onPressed: () {
            UpdateStatus();
          },
          child: const Icon(Icons.done_rounded, size: 26)),
    );
  }

  // ignore: non_constant_identifier_names
  UpdateStatus() async {
    if (lastname.text == '') {
      log('Error 1');
      return;
    }
    if (name.text == '') {
      log('Error 2');
      return;
    }
    log('Update Completed : ${name.text}');
    await db.collection('users').doc(user.uid).update({
      "first": name.text,
      "last": lastname.text,
    });
    Navigator.pop(context);
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
        fillColor: const Color.fromARGB(255, 46, 45, 45),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff4059ad))),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ui.foregroundHead),
        ),
      ),
    );
  }
}
