import 'package:flutter/material.dart';
import 'package:arborrr_p001/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'dart:developer';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String verificationIDR = "";
  bool otpCodehide = false;
  bool phide = true;
  String btn = 'ดำเนินการต่อ';
  String inputHeader = "เบอร์โทรศัพท์";
  TextEditingController phoneController = TextEditingController();
  // TextEditingController otpCode = TextEditingController();

  get otpCode => null;
  bool shouldPop = true;
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
      body: Wrap(runSpacing: 30, alignment: WrapAlignment.center, children: <
          Widget>[
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(inputHeader, style: const TextStyle(color: Colors.white)),
              Visibility(
                visible: otpCodehide,
                child: Center(
                  child: OTPTextField(
                      hasError: false,
                      controller: otpCode,
                      length: 6,
                      fieldWidth: 45,
                      fieldStyle: FieldStyle.underline,
                      outlineBorderRadius: 15,
                      width: MediaQuery.of(context).size.width,
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      style: const TextStyle(
                          fontSize: 32, color: Color.fromARGB(255, 29, 29, 29)),
                      onChanged: (pin) {},
                      onCompleted: (pin) {
                        log("Completed: " + pin);
                        verifyCode(pin);
                      }),
                ),
              ),
              Visibility(
                visible: phide,
                child: Container(
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
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 25),
          child: RichText(
            text: const TextSpan(
              text:
                  '    โดยการดำเนินการต่อ หมายความว่าคุณยินยอมให้จัดเก็บข้อมูลส่วนบุคคลตามเงื่อนไข  ',
              children: <TextSpan>[
                TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                    text: ' และคุณจะได้รับข้อความ SMS สำหรับการยืนยันตัวตน'),
              ],
              style: TextStyle(fontFamily: 'SukhumvitSet'),
            ),
          ),
        ),
        SizedBox(
          height: 54,
          width: MediaQuery.of(context).size.width - 40,
          child: ElevatedButton(
            autofocus: true,
            style: ElevatedButton.styleFrom(primary: const Color(0xFF353535)),
            onPressed: () async {
              verifyNumber();

              final prefs = await SharedPreferences.getInstance();
              prefs.setBool('showHome', true);
              clicked();
            },
            child: Text(
              btn,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ),
      ]),
    );
  }

  // backend function
  clicked() {
    //!Move to verifyNumber later
    setState(() {
      btn = 'เข้าสู่ระบบ';
      inputHeader = "OTP Code";
      phide = false;
      otpCodehide = true;
    });
  }

  void verifyNumber() {
    auth.verifyPhoneNumber(
        phoneNumber: '+66${phoneController.text}',
        timeout: const Duration(minutes: 1),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential).then((value) {
            log("SUCCESS");
          });
        },
        codeSent: (String verificationID, int? resendToken) {
          verificationIDR = verificationID;
          otpCodehide = true;
          setState(() {
            btn = 'Login';
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {},
        verificationFailed: (FirebaseAuthException error) {
          log("FAILD TO Verificate");
        });
  }

  void verifyCode(pin) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationIDR,
      smsCode: pin,
    );

    await auth.signInWithCredential(credential).then((value) {
      log("Success login!!");
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MyHomePage()),
      );
    });
  }
}
