import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late FirebaseAuth _auth;
  late FirebaseFirestore _firestore;

  final _formKey = GlobalKey<FormState>();

  String accountNameLabelText = 'ชื่อบัญชี';
  String emailLabelText = 'อีเมล';
  String passwordLabelText = 'รหัสผ่าน';
  String passwordConfirmedLabelText = 'ยืนยันรหัสผ่าน';

  String accountName = '';
  String email = '';
  String password = '';
  String passwordConfirmed = '';

  String error = '';

  @override
  void initState() {
    super.initState();
    initFirebase();
  }

  void initFirebase() async {
    _auth = FirebaseAuth.instance;
    _firestore = FirebaseFirestore.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          color: kMainColor,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              const Image(
                image: AssetImage('assets/signup-logo.png'),
                height: 170,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 25.0, bottom: 10),
                child: const Text(
                  "สมัครบัญชี",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 45,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              Container(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 45,
                        ),
                        getTextFormField(
                          accountNameLabelText,
                          Icons.person,
                        ),
                        getTextFormField(
                          emailLabelText,
                          Icons.email,
                        ),
                        getTextFormField(
                          passwordLabelText,
                          Icons.key,
                        ),
                        getTextFormField(
                          passwordConfirmedLabelText,
                          Icons.key,
                        ),
                        if (error != '')
                          Text(
                            error,
                            style: const TextStyle(
                              color: kRedColor,
                              fontSize: 15,
                            ),
                          ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            getTextButton(
                              'สร้างบัญชี',
                              Colors.white,
                              kMainColor,
                              true,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            getTextButton(
                              'ยกเลิก',
                              kMainColor,
                              Colors.white,
                              false,
                            ),
                          ],
                        ),
                      ],
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

  InputBorder getBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: BorderSide(color: color),
    );
  }

  Widget getTextFormField(String labelText, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        width: 350,
        height: 80,
        child: TextFormField(
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: kMainColor,
            ),
            enabledBorder: getBorder(kMainColor),
            focusedBorder: getBorder(kMainColor),
            errorBorder: getBorder(kRedColor),
            focusedErrorBorder: getBorder(kRedColor),
            labelText: '$labelText*',
            labelStyle: const TextStyle(
              fontSize: 15,
            ),
            floatingLabelStyle: const TextStyle(
              color: kMainColor,
              fontSize: 20,
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            errorStyle: const TextStyle(height: 0.75),
          ),
          obscureText: labelText.contains('รหัสผ่าน'),
          onChanged: (value) {
            if (labelText == accountNameLabelText) {
              accountName = value;
            } else if (labelText == emailLabelText) {
              email = value;
            } else if (labelText == passwordLabelText) {
              password = value;
            } else if (labelText == passwordConfirmedLabelText) {
              passwordConfirmed = value;
            }
          },
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'กรุณากรอก$labelText';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget getTextButton(
    String text,
    Color foregroundColor,
    Color backgroundColor,
    bool validate,
  ) {
    return TextButton(
      style: ButtonStyle(
        padding:
            MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(10)),
        foregroundColor: MaterialStateProperty.all<Color>(foregroundColor),
        backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(color: foregroundColor),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        minimumSize: MaterialStateProperty.all<Size>(const Size(165, 55)),
      ),
      onPressed: () async {
        if (validate) {
          if (_formKey.currentState!.validate()) {
            if (password == passwordConfirmed) {
              try {
                await _auth.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                Map<String, dynamic> data = {
                  'email': email,
                  'accountName': accountName,
                };
                _firestore.collection(kAccountNameCollection).add(data);
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => getDialog(
                    'สร้างบัญชีสำเร็จ !',
                    Icons.check_circle,
                    kGreenColor,
                  ),
                );
              } on FirebaseAuthException catch (e) {
                setState(() {
                  error = getMessageFromError(e.code);
                });
              }
            } else {
              setState(() {
                error = 'รหัสผ่านไม่ตรงกับยืนยันรหัสผ่าน';
              });
            }
          }
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const LoginScreen(),
            ),
          );
        }
      },
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }

  Widget getDialog(String text, IconData icon, Color color) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: const EdgeInsets.only(bottom: 15),
      title: Container(
        width: 340,
        height: 130,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          color: color,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 90,
        ),
      ),
      content: SizedBox(
        height: 70,
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 30,
                color: color,
              ),
            ),
          ],
        ),
      ),
      actions: [
        getTextButton(
          'ตกลง',
          Colors.white,
          color,
          false,
        ),
      ],
    );
  }

  String getMessageFromError(e) {
    switch (e) {
      case "email-already-in-use":
        return "อีเมลนี้ถูกลงทะเบียนไว้แล้ว";
      case "invalid-email":
        return "อีเมลไม่ถูกต้อง";
      case "weak-password":
        return "กรุณาเปลี่ยนรหัสผ่าน";
      default:
        return "สร้างบัญชีไม่สำเร็จ กรุณาลองอีกครั้ง";
    }
  }
}
