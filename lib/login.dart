import 'package:flutter/material.dart';
import 'package:arborrr_p001/var.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dart:developer';
// import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String verificationIDR = "";
  bool otpCodehide = false;
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpCode = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

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
                          child: TextField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            obscureText: false,
                            maxLength: 9,
                            decoration: const InputDecoration(
                              counterText: "",
                              prefixText: "+66 | ",
                              hintText: "กรุณากรอกหมายเลขโทรศัพท์",
                              hintStyle: TextStyle(fontSize: 18),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
              const SizedBox(height: 20), //!MUST CHANGE
              // Login button
              SizedBox(
                height: 54,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: primaryColor),
                  onPressed: () async {
                    verifyNumber();
                    // final prefs = await SharedPreferences.getInstance();
                    // prefs.setBool('showHome', true);
                    // Navigator.of(context).pushReplacement(
                    //   MaterialPageRoute(
                    //       builder: (context) => const MyHomePage()),
                    // );
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
        },
        codeAutoRetrievalTimeout: (String verificationID) {},
        verificationFailed: (FirebaseAuthException error) {
          // print("FAILD TO LOGIN");
        });
  }

  void verifyCode() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationIDR, smsCode: otpCode.text);

    await auth.signInWithCredential(credential).then((value) {
      // print("Success login!!");
    });
  }
}
