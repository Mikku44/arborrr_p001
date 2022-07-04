import 'package:flutter/material.dart';
import 'package:arborrr_p001/functions/userInfo.dart' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';

class Noti extends StatefulWidget {
  const Noti({Key? key}) : super(key: key);

  @override
  State<Noti> createState() => _NotiState();
}

class _NotiState extends State<Noti> {
  bool disturb = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ui.Themecolor,
          elevation: 0,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10))),
          title: Text('Notification', style: TextStyle(color: ui.foreground)),
          actions: [
            Row(
              children: [
                Text('Do not disturb', style: TextStyle(color: ui.foreground)),
                toggleBtn(),
              ],
            )
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('notification')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Card();
              }
              return ListView(
                children: snapshot.data!.docs
                    .map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      String phase = 'Hours ago';
                      //transform seconds to hours
                      var date = (int.parse('${Timestamp.now().seconds}') -
                              int.parse('${data['timeStamp'].seconds}')) /
                          3600;
                      if (date > 23) {
                        date = date / 24;
                        phase = 'Days ago';
                      }

                      log('${date}');
                      return Card(
                        color: ui.Themecolor,
                        child: ListTile(
                          onTap: () {},
                          leading: const CircleAvatar(radius: 5),
                          title: Text(data['title'],
                              style: TextStyle(color: ui.foreground)),
                          subtitle: Text("${date.round()} $phase",
                              style: TextStyle(color: ui.foreground)),
                        ),
                      );
                    })
                    .toList()
                    .cast(),
              );
            }));
  }

  Widget toggleBtn() => Transform.scale(
        scale: 1,
        child: Switch.adaptive(
            value: disturb,
            onChanged: (value) {
              setState(() {
                disturb = value;
              });
            }),
      );
}
