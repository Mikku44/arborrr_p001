import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';

const primaryColor = Color(0xFF4059AD);
//connect to firebase
var db = FirebaseFirestore.instance;
//Access to user information
final user = FirebaseAuth.instance.currentUser!;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        title: const Text(
          "Profile",
        ),
        elevation: 0,
      ),
      body: (Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: ListView(children: [
          //Account
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Wrap(
                children: [
                  Card(
                    elevation: 0,
                    color: const Color(0xcc4059ad),
                    child: Container(
                      width: 100,
                      padding: const EdgeInsets.all(5),
                      child: Row(children: const [
                        Icon(Icons.rocket_launch, color: Colors.white),
                        Text(' Account ',
                            style: TextStyle(color: Colors.white)),
                      ]),
                    ),
                  ),
                  Row(children: [
                    SizedBox(
                        height: 145,
                        width: 145,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image(
                                fit: BoxFit.fitHeight,
                                image: NetworkImage(
                                    'https://images.unsplash.com/photo-1472718790858-091e4a486677?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1332&q=80')))),
                    Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Text('Name',
                                    style: const TextStyle(fontSize: 32)),
                              ]),
                              InkWell(
                                onTap: () {},
                                child: Row(children: const [
                                  Text('แก้ไขและจัดการข้อมูล',
                                      style: TextStyle(fontSize: 16))
                                ]),
                              ),
                              const Text('Phone',
                                  style: TextStyle(fontSize: 10)),
                              Text('${user.phoneNumber}',
                                  style: TextStyle(fontSize: 16)),
                              const Text('Email',
                                  style: TextStyle(fontSize: 10)),
                              Text('contact@arborrr.com',
                                  style: TextStyle(fontSize: 16)),
                            ]))
                  ]),
                  Card(
                    color: const Color(0xff97D8C4),
                    child: SizedBox(
                      height: 74,
                      width: 354,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Icon(Icons.directions_car, size: 48),
                          Text('บริการหลังการซ่อมเหลืออีก 5 วัน',
                              style: TextStyle(fontSize: 16))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //Help & Feedback
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              child: Wrap(
                direction: Axis.vertical,
                spacing: 10,
                children: [
                  Card(
                    elevation: 0,
                    color: const Color(0xcc4059ad),
                    child: Container(
                      width: 150,
                      padding: EdgeInsets.all(5),
                      child: Row(children: const [
                        Icon(Icons.support, color: Colors.white),
                        Text(' Help & Feedback ',
                            style: const TextStyle(color: Colors.white)),
                      ]),
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      child: InkWell(
                          child: const Text('ศูนย์ช่วยเหลือ'), onTap: () {})),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      child: InkWell(
                          child: const Text('ข้อเสนอแนะ & ความคิดเห็น'),
                          onTap: () {})),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      child: InkWell(
                          child: const Text('Terms & Policies'), onTap: () {})),
                ],
              ),
            ),
          ), //Help & Feedback
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              child: Wrap(
                direction: Axis.vertical,
                spacing: 10,
                children: [
                  Card(
                    elevation: 0,
                    color: const Color(0xcc4059ad),
                    child: Container(
                      width: 100,
                      padding: const EdgeInsets.all(5),
                      child: Row(children: const [
                        Icon(Icons.settings, color: Colors.white),
                        Text(' General ',
                            style: TextStyle(color: Colors.white)),
                      ]),
                    ),
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: InkWell(
                          child: const Text('การแจ้งเตือน'), onTap: () {})),
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: InkWell(
                          child: const Text('รูปลักษณ์'), onTap: () {})),
                ],
              ),
            ),
          ),
          //Logout Button

          SizedBox(
            height: 54,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
                child: const Text(
                  'ลงชื่อออก',
                ),
                onPressed: () async {
                  FirebaseAuth.instance.signOut();
                  // Navigator.of(context).pushReplacement(
                  //   MaterialPageRoute(builder: (context) => const Login()),
                  // );
                },
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: const Color.fromARGB(255, 223, 30, 69),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)))),
          ),
          const SizedBox(height: 5)
        ]),
      )),
    );
  }
}
