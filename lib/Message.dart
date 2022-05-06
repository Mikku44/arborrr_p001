import 'package:flutter/Material.dart';

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
          title: const Text("Message")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Expanded(
            child: Material(
              color: primaryColor,
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(10.0),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Chat message',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
