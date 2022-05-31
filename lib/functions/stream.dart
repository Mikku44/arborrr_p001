import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';

class UserInformation extends StatefulWidget {
  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(),
          body: ElevatedButton(
              child: const Text('Click'),
              onPressed: () async {
                final Stream<QuerySnapshot> _usersStream =
                    FirebaseFirestore.instance.collection('test').snapshots();
                log('clicked');
                _usersStream.listen(
                  (event) {
                    log(event.toString());
                  },
                );
              })),
    );
  }
}
