// ignore_for_file: file_names

import 'package:arborrr_p001/main.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';
import 'dart:math';

//connect to firebase
var db = FirebaseFirestore.instance;

//Access to user information
final user = FirebaseAuth.instance.currentUser!;
final phone = user.phoneNumber;

TextEditingController name = TextEditingController();
TextEditingController lastname = TextEditingController();

class CreateUser extends StatefulWidget {
  const CreateUser({Key? key}) : super(key: key);
  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  var colorbtn = Colors.black26;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 50),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Wrap(
          runSpacing: 20,
          children: [
            const Text("Create a \nNew account",
                style: TextStyle(fontSize: 32, color: Colors.black)),
            Wrap(children: [
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: name,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Enter your name",
                      hintStyle: TextStyle(fontSize: 18),
                      enabledBorder: UnderlineInputBorder(),
                      focusedBorder: UnderlineInputBorder(),
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: lastname,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Enter your last-name",
                      hintStyle: TextStyle(fontSize: 18),
                      enabledBorder: UnderlineInputBorder(),
                      focusedBorder: UnderlineInputBorder(),
                    ),
                  )),
            ]),
            SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                height: 54,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: colorbtn),
                    child: const Text("Let's Go!"),
                    onPressed: () async {
                      if (name.text != '' && lastname.text != '') {
                        database();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const MyHomePage()));
                      } else {
                        null;
                      }
                    }))
          ],
        ),
      ),
    );
  }
}

database() {
  List pic = [
    'https://images.unsplash.com/photo-1575931953324-fcac7094999e?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=80&raw_url=true&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170',
    'https://images.unsplash.com/photo-1652649115861-394ac7a73095?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=80&raw_url=true&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580',
    'https://images.unsplash.com/photo-1652651589282-edc8ed631951?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=80&raw_url=true&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064',
    'https://images.unsplash.com/photo-1652911366999-ea9c0e99a2be?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=80&raw_url=true&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387',
    'https://images.unsplash.com/photo-1652810454583-b47fe7e961e6?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=80&raw_url=true&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170',
    'https://images.unsplash.com/photo-1639789972237-7ee9434066ed?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=80&raw_url=true&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170',
    'https://images.unsplash.com/photo-1471479917193-f00955256257?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=80&raw_url=true&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1931',
    'https://images.unsplash.com/photo-1652911367204-48b7ff0a2c53?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=80&raw_url=true&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387',
    'https://images.unsplash.com/photo-1652940428792-51ae5ab540a6?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=80&raw_url=true&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=385'
  ];
  // Create a new user with a first and last name
  final bio = <String, dynamic>{
    "first": name.text,
    "last": lastname.text,
    "phone": phone,
    'email': 'not sign-up',
    "pic": pic[Random().nextInt(10)]
  };
  // set new document with uid
  db.collection('users').doc(user.uid).set(bio);
  // Add a new document with a generated ID
  // db.collection("users").add(user).then((DocumentReference doc) =>
  //     log('DocumentSnapshot added with ID: ${doc.id}'));
}
