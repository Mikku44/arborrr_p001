import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:arborrr_p001/login.dart';

var db = FirebaseFirestore.instance;
//connect to collection users
var x = db.collection('users').doc(user.uid);

class Email extends StatefulWidget {
  const Email({Key? key}) : super(key: key);

  @override
  State<Email> createState() => _EmailState();
}

class _EmailState extends State<Email> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: x.get(),
      builder: (_, snapshot) {
        if (snapshot.hasError) return Text('Error = ${snapshot.error}');

        if (snapshot.hasData) {
          var data = snapshot.data!.data();
          var value = data!['email'];
          return Text('$value', style: const TextStyle(fontSize: 16));
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
