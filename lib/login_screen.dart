import 'package:flutter/material.dart';

import 'constants.dart';
import 'my_bottom_navigation_bar.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        color: kMainColor,
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 90,
            ),
            const Image(image: AssetImage('assets/login-logo.png')),
            Expanded(
              child: FractionallySizedBox(
                heightFactor: 0.9,
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 45,
                      ),
                      getTextField(
                        Icons.email,
                        'อีเมล',
                      ),
                      getTextField(
                        Icons.key,
                        'รหัสผ่าน',
                      ),
                      const Text(
                        '***อีเมลหรือรหัสผ่านไม่ถูกต้อง***',
                        style: TextStyle(
                          color: kRedColor,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      getTextButton(
                        'เข้าสู่ระบบ',
                        const MyBottomNavigationBar(),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: <Widget>[
                          getDivider(),
                          const Text(
                            "ยังไม่มีบัญชี ?",
                            style: TextStyle(
                              color: kMainColor,
                              fontSize: 15,
                            ),
                          ),
                          getDivider(),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      getTextButton(
                        'สมัครบัญชี',
                        const SignupScreen(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
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

  Widget getTextField(IconData icon, String labelText) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        width: 350,
        height: 75,
        child: TextField(
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: kMainColor,
            ),
            enabledBorder: getBorder(kMainColor),
            focusedBorder: getBorder(kMainColor),
            labelText: labelText,
            labelStyle: const TextStyle(
              fontSize: 15,
            ),
            floatingLabelStyle: const TextStyle(
              color: kMainColor,
              fontSize: 20,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),
    );
  }

  Widget getTextButton(String text, Widget route) {
    return TextButton(
      style: ButtonStyle(
        padding:
            MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(10)),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        backgroundColor: MaterialStateProperty.all<Color>(kMainColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        minimumSize: MaterialStateProperty.all<Size>(const Size(350, 50)),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => route,
          ),
        );
      },
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }

  Widget getDivider() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: const Divider(
          color: kMainColor,
          thickness: 0.75,
        ),
      ),
    );
  }
}
