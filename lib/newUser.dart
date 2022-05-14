// ignore_for_file: file_names

import 'package:arborrr_p001/main.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

TextEditingController name = TextEditingController();
TextEditingController lastname = TextEditingController();
TextEditingController year = TextEditingController();

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
                    style: const TextStyle(color: Colors.black),
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
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: year,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Enter a year",
                      hintStyle: TextStyle(fontSize: 18),
                      enabledBorder: UnderlineInputBorder(),
                      focusedBorder: UnderlineInputBorder(),
                    ),
                  ))
            ]),
            SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                height: 54,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: colorbtn),
                    child: const Text("Let's Go!"),
                    onPressed: () async {
                      if (name.text != '' &&
                          lastname.text != '' &&
                          year.text != '') {
                        final prefs = await SharedPreferences.getInstance();
                        String phone = prefs.getString('phone').toString();
                        log(phone);
                        var db = FirebaseFirestore.instance;
                        // Create a new user with a first and last name
                        final user = <String, dynamic>{
                          "first": name.text,
                          "last": lastname.text,
                          "born": year.text,
                          "phone": phone
                        };
                        // Add a new document with a generated ID
                        db.collection("users").add(user).then((DocumentReference
                                doc) =>
                            log('DocumentSnapshot added with ID: ${doc.id}'));

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
