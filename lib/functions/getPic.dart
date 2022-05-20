import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:arborrr_p001/login.dart';

var db = FirebaseFirestore.instance;
//connect to collection users
var x = db.collection('users').doc(user.uid);

class Pic extends StatefulWidget {
  const Pic({Key? key}) : super(key: key);

  @override
  State<Pic> createState() => _PicState();
}

class _PicState extends State<Pic> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: x.get(),
      builder: (_, snapshot) {
        if (snapshot.hasError) return Text('Error = ${snapshot.error}');

        if (snapshot.hasData) {
          var data = snapshot.data!.data();
          var value = data!['pic'];
          return Image(fit: BoxFit.cover, image: NetworkImage('$value'));
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
