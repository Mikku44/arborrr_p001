import 'package:arborrr_p001/newUser.dart';
import 'package:arborrr_p001/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

const primaryColor = Color(0xFF4059AD);

//connect to firebase
var db = FirebaseFirestore.instance;

//Access to user information
FirebaseAuth auth = FirebaseAuth.instance;
final user = FirebaseAuth.instance.currentUser!;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Future<bool?> warNing(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text("คุณต้องการปิดแอพหรือไหม?",
                style: TextStyle(color: Colors.white)),
            content: const Text("กดยืนยันเพื่อปิดแอพลิเคชั่นตอนนี้",
                style: TextStyle(color: Colors.white)),
            backgroundColor: const Color(0xFF252525),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                style: ElevatedButton.styleFrom(
                    primary: Colors.white, onPrimary: Colors.red),
                child: const Text(
                  "Yes",
                  style: TextStyle(color: Color.fromARGB(255, 255, 58, 58)),
                ),
              ),
              TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text(
                    "No",
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  ))
            ],
          ));

  String verificationIDR = "";
  bool otpCodehide = false;
  bool hasError = false;
  String btn = 'ดำเนินการต่อ';
  String inputHeader = "เบอร์โทรศัพท์";
  TextEditingController phoneController = TextEditingController();

  get otpCode => null;

  bool shouldPop = true;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await warNing(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: primaryColor,
          leading: Visibility(
              visible: otpCodehide,
              child: InkWell(
                  onTap: () {
                    otpCodehide = false;
                    btn = 'ดำเนินการต่อ';
                    inputHeader = "เบอร์โทรศัพท์";
                    setState(() {});
                  },
                  child: const Icon(Icons.arrow_back_ios_new_rounded))),
          title: const Text('Login'),
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
                        hasError: hasError,
                        controller: otpCode,
                        length: 6,
                        fieldWidth: 45,
                        fieldStyle: FieldStyle.underline,
                        outlineBorderRadius: 15,
                        width: MediaQuery.of(context).size.width,
                        textFieldAlignment: MainAxisAlignment.spaceAround,
                        style: const TextStyle(
                            fontSize: 32,
                            color: Color.fromARGB(255, 29, 29, 29)),
                        onChanged: (pin) {
                          hasError = false;
                          setState(() {});
                        },
                        onCompleted: (pin) {
                          log("Completed: " + pin);
                          verifyCode(pin);
                        }),
                  ),
                ),
                Visibility(
                  visible: !otpCodehide,
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
              onPressed: () {
                if (!otpCodehide) {
                  if (phoneController.text != '' &&
                      (phoneController.text).length == 9 &&
                      (phoneController.text)[0] != '0') {
                    verifyNumber();
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                                title: const Text('ทำรายการไม่สำเร็จ'),
                                content: const Text(
                                    'โปรดใส่หมายเลขโทรศัพท์ของคุณ ตัวอย่างเช่น (0)622080994'),
                                actions: [
                                  TextButton(
                                    child: const Text("เข้าใจแล้ว"),
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                  ),
                                ]));
                  }
                } else {
                  verifyNumber();
                }
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
      ),
    );
  }

  // backend function

  void verifyNumber() {
    auth.verifyPhoneNumber(
        phoneNumber: '+66${phoneController.text}',
        timeout: const Duration(minutes: 2),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential).then((value) {
            log("SUCCESS");
          });
        },
        codeSent: (String verificationID, int? resendToken) {
          verificationIDR = verificationID;
          btn = 'รับรหัสผ่านอีกครั้ง';
          inputHeader = "OTP Code";
          otpCodehide = true;
          setState(() {});
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

    try {
      await auth.signInWithCredential(credential).then((value) {
        log("Success login!!");
        newbie(context);
      });
    } catch (e) {
      hasError = true;
      setState(() {});
      log('Error');
    }
  }
}

//To Check It's new User?
newbie(context) async {
  final docRef = db.collection("users").doc(user.uid);
  docRef.snapshots().listen(
    (event) {
      log('${event.data()}');
      if (event.data() == null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const CreateUser()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MyHomePage()));
      }
    },
    onError: (error) {
      log('error $error');
    },
  );
}
