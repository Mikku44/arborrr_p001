import 'package:flutter/material.dart';
import 'package:arborrr_p001/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';
// import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String verificationIDR = "";
  bool otpCodehide = false;
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpCode = TextEditingController();

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
      body: Wrap(
          runSpacing: 30,
          alignment: WrapAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: const Text("เบอร์โทรศัพท์",
                          style: TextStyle(color: Colors.white)),
                    ),
                    Container(
                      height: 54,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        maxLength: 9,
                        decoration: const InputDecoration(
                          counterText: "",
                          prefixText: "  +66 | ",
                          hintText: " หมายเลขโทรศัพท์",
                          hintStyle: TextStyle(fontSize: 18),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ]),
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                child: const Text(
                    'โดยการดำเนินการต่อ หมายความว่าคุณยินยอมให้จัดเก็บข้อมูลส่วนบุคคลตามเงื่อนไข Privacy Policy และคุณจะได้รับข้อความ SMS สำหรับการยืนยันตัวตน',
                    style: TextStyle(color: Colors.white))),
            // Login button
            SizedBox(
              height: 54,
              width: 350,
              child: ElevatedButton(
                autofocus: true,
                style: ElevatedButton.styleFrom(primary: Color(0xFF353535)),
                onPressed: () async {
                  // verifyNumber();
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool('showHome', true);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const MyHomePage()),
                  );
                },
                child: const Text(
                  'ดำเนินการต่อ',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ]),
    );
  }

  void verifyNumber() {
    auth.verifyPhoneNumber(
        phoneNumber: '+66' + phoneController.text,
        timeout: const Duration(minutes: 1),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential).then((value) {
            log("SUCCESS");
          });
        },
        codeSent: (String verificationID, int? resendToken) {
          verificationIDR = verificationID;
          otpCodehide = true;
          // setState(() {});
        },
        codeAutoRetrievalTimeout: (String verificationID) {},
        verificationFailed: (FirebaseAuthException error) {
          log("FAILD TO Verificate");
        });
  }

  void verifyCode() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationIDR, smsCode: otpCode.text);

    await auth.signInWithCredential(credential).then((value) {
      log("Success login!!");
    });
  }
}
