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
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: primaryColor,
              title: const Text(
                "Profile",
              ),
              elevation: 0,
            ),
            body: ListView(children: [
              //Account
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      topLeft: Radius.circular(20.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Wrap(
                    children: [
                      Container(
                        width: 100,
                        padding: const EdgeInsets.all(5),
                        child: Row(children: const [
                          Icon(Icons.account_balance_outlined,
                              color: Colors.black38),
                          Text(' Account ',
                              style: TextStyle(color: Colors.black38)),
                        ]),
                      ),
                      Column(children: [
                        SizedBox(
                            height: 145,
                            width: 145,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image(
                                    fit: BoxFit.cover,
                                    image: NetworkImage('${value[4]}')))),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${value[0]} ${value[1]}',
                                    style: const TextStyle(fontSize: 24)),
                                InkWell(
                                  onTap: () {},
                                  child: Row(children: const [
                                    Text('แก้ไขและจัดการข้อมูล',
                                        style: TextStyle(fontSize: 16))
                                  ]),
                                ),
                                const Text('Phone',
                                    style: TextStyle(fontSize: 10)),
                                Text('${value[2]}',
                                    style: const TextStyle(fontSize: 16)),
                                const Text('Email',
                                    style: TextStyle(fontSize: 10)),
                                Text('${value[3]}',
                                    style: const TextStyle(fontSize: 16)),
                              ]),
                        )
                      ]),

                      Wrap(
                        direction: Axis.vertical,
                        spacing: 10,
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
                                  child: const Text('ข้อเสนอแนะ & ความคิดเห็น'),
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
                        spacing: 10,
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
                      ), //Logout Button

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
                                primary: const Color.fromARGB(255, 223, 30, 69),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14)))),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
