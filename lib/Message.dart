// ignore_for_file: file_names

import 'package:flutter/Material.dart';
import 'package:flutter/material.dart';

const primaryColor = Color(0xFF4059AD);
// import 'package:shared_preferences/shared_preferences.dart';

class Message extends StatefulWidget {
  const Message({Key? key}) : super(key: key);

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: primaryColor,
          centerTitle: true,
          title: const Text("Message")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
                padding: const EdgeInsets.only(top: 10, left: 20),
                color: const Color(0xff4059ad),
                child: const Text('HALEY\nQuenn',
                    style: TextStyle(fontSize: 32, color: Colors.white))),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(25),
              child: ListView(children: const [
                Text('Start'),
                Text('hello world'),
                Text('hello world'),
                Text('hello world'),
                Text('hello world'),
                Text('hello world'),
                Text('hello world'),
                Text('hello world'),
                Text('hello world'),
                Text('hello world'),
                Text('hello world'),
                Text('hello world'),
                Text('hello world'),
                Text('hello world'),
                Text('hello world'),
                Text('END')
              ]),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    topLeft: Radius.circular(20.0)),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Container(
              width: MediaQuery.of(context).size.width - 30,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 232, 232, 232),
                  borderRadius: BorderRadius.circular(50)),
              child:
                  Stack(alignment: AlignmentDirectional.centerEnd, children: [
                const Padding(
                    padding: EdgeInsets.only(left: 20, right: 70),
                    child: TextField(
                        scrollController: null,
                        controller: null,
                        decoration: InputDecoration(
                            hintText: 'Type somthing....',
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none))),
                SizedBox(
                    height: 40,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: const Color(0xff4059ad),
                            shape: const CircleBorder()),
                        onPressed: () {},
                        child: const Icon(Icons.send_rounded, size: 24)))
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
