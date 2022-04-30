import 'package:flutter/material.dart';
import 'package:arborrr_p001/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          children: const [
            Text('Login'),
          ],
        ),
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 100),
        child: Form(
          child: Column(
            children: [
              Positioned(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("เบอร์โทรศัพท์",
                          style: TextStyle(color: Colors.white)),
                      const SizedBox(height: 10), //!MUST CHAGE
                      Container(
                        // margin: const EdgeInsets.symmetric(vertical: 250),
                        height: 54,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: const TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "e.g. 0620503184",
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
              const SizedBox(height: 200), //!MUST CHANGE
              SizedBox(
                height: 54,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: primaryColor),
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool('showHome', true);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => const MyHomePage()),
                    );
                  },
                  child: const Text(
                    'ส่งรหัสผ่าน',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
