import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:arborrr_p001/login.dart';
import 'dart:developer';

var db = FirebaseFirestore.instance;
//connect to collection users
var x = db.collection('users').doc(user.uid);

class fireStoreUser extends StatefulWidget {
  const fireStoreUser({Key? key}) : super(key: key);

  @override
  State<fireStoreUser> createState() => _fireStoreUserState();
}

class _fireStoreUserState extends State<fireStoreUser> {
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
              Stack(children: [
                //backgroundColor
                Container(
                    color: Colors.black45,
                    height: 200,
                    width: MediaQuery.of(context).size.width),
                //Account
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
                          CircleAvatar(
                              radius: 100,
                              backgroundImage: NetworkImage('${value[4]}')),
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
                                                          20))),
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
                          spacing: 20,
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

                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: InkWell(
                                    child: const Text('ศูนย์ช่วยเหลือ'),
                                    onTap: () {})),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: InkWell(
                                    child:
                                        const Text('ข้อเสนอแนะ & ความคิดเห็น'),
                                    onTap: () {})),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: InkWell(
                                    child: const Text('Terms & Policies'),
                                    onTap: () async {
                                      db
                                          .collection('users')
                                          .doc(user.uid)
                                          .snapshots()
                                          .listen((event) {
                                        log('${event.data()}');
                                      });
                                    })),
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
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: InkWell(
                                    child: const Text('การแจ้งเตือน'),
                                    onTap: () {})),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: InkWell(
                                    child: const Text('รูปลักษณ์'),
                                    onTap: () {})),
                          ],
                        ),
                        SizedBox(height: 20, child: Text('  ')), //Logout Button

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
                )
              ]),
            ]),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
