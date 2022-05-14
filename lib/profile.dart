import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:arborrr_p001/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

const primaryColor = Color(0xFF4059AD);
var db = FirebaseFirestore.instance;

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
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: ListView(children: [
          //Account
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Wrap(
                children: [
                  Card(
                    elevation: 0,
                    color: Color(0xcc4059ad),
                    child: Container(
                      width: 100,
                      padding: EdgeInsets.all(5),
                      child: Row(children: [
                        Icon(Icons.rocket_launch, color: Colors.white),
                        Text(' Account ',
                            style: TextStyle(color: Colors.white)),
                      ]),
                    ),
                  ),
                  Row(children: [
                    Container(
                        height: 145,
                        width: 145,
                        child: Card(color: Color.fromARGB(255, 125, 125, 125))),
                    Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Text('Name', style: TextStyle(fontSize: 32)),
                              ]),
                              InkWell(
                                onTap: () {},
                                child: Row(children: [
                                  Text('แก้ไขและจัดการข้อมูล',
                                      style: TextStyle(fontSize: 16))
                                ]),
                              ),
                              Text('Phone', style: TextStyle(fontSize: 10)),
                              Text('0620503184',
                                  style: TextStyle(fontSize: 16)),
                              Text('Email', style: TextStyle(fontSize: 10)),
                              Text('contact@arborrr.com',
                                  style: TextStyle(fontSize: 16)),
                            ]))
                  ]),
                  Card(
                    color: Color(0xff97D8C4),
                    child: Container(
                      height: 74,
                      width: 354,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
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
              padding: EdgeInsets.all(10),
              child: Wrap(
                direction: Axis.vertical,
                spacing: 10,
                children: [
                  Card(
                    elevation: 0,
                    color: Color(0xcc4059ad),
                    child: Container(
                      width: 150,
                      padding: EdgeInsets.all(5),
                      child: Row(children: [
                        Icon(Icons.support, color: Colors.white),
                        Text(' Help & Feedback ',
                            style: TextStyle(color: Colors.white)),
                      ]),
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      child:
                          InkWell(child: Text('ศูนย์ช่วยเหลือ'), onTap: () {})),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      child: InkWell(
                          child: Text('ข้อเสนอแนะ & ความคิดเห็น'),
                          onTap: () {})),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      child: InkWell(
                          child: Text('Terms & Policies'), onTap: () {})),
                ],
              ),
            ),
          ), //Help & Feedback
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              child: Wrap(
                direction: Axis.vertical,
                spacing: 10,
                children: [
                  Card(
                    elevation: 0,
                    color: Color(0xcc4059ad),
                    child: Container(
                      width: 100,
                      padding: EdgeInsets.all(5),
                      child: Row(children: [
                        Icon(Icons.settings, color: Colors.white),
                        Text(' General ',
                            style: TextStyle(color: Colors.white)),
                      ]),
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      child:
                          InkWell(child: Text('การแจ้งเตือน'), onTap: () {})),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      child: InkWell(child: Text('รูปลักษณ์'), onTap: () {})),
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
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool('showHome', true);
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                },
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: Color.fromARGB(255, 223, 30, 69),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)))),
          ),
          const SizedBox(height: 5)
        ]),
      )),
    );
  }
}
