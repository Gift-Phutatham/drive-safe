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
        color: kBackgroundColor,
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 100,
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
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: SizedBox(
                          width: 350,
                          height: 75,
                          child: TextField(
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.email,
                                color: kTextColor,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide:
                                    const BorderSide(color: kBackgroundColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide:
                                    const BorderSide(color: kBackgroundColor),
                              ),
                              labelText: 'อีเมล',
                              labelStyle: const TextStyle(
                                color: kTextColor,
                                fontSize: 15,
                                fontFamily: 'Prompt',
                              ),
                              floatingLabelStyle: const TextStyle(
                                color: kTextColor,
                                fontSize: 20,
                                fontFamily: 'Prompt',
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 15),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: SizedBox(
                          width: 350,
                          height: 65,
                          child: TextField(
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.key,
                                color: kTextColor,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide:
                                    const BorderSide(color: kBackgroundColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide:
                                    const BorderSide(color: kBackgroundColor),
                              ),
                              labelText: 'รหัสผ่าน',
                              labelStyle: const TextStyle(
                                color: kTextColor,
                                fontSize: 15,
                                fontFamily: 'Prompt',
                              ),
                              floatingLabelStyle: const TextStyle(
                                color: kTextColor,
                                fontSize: 20,
                                fontFamily: 'Prompt',
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 15),
                            ),
                          ),
                        ),
                      ),
                      const Text(
                        '***อีเมลหรือรหัสผ่านไม่ถูกต้อง***',
                        style: TextStyle(
                          color: kRedColor,
                          fontSize: 15,
                          fontFamily: "prompt",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(10)),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              kBackgroundColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          minimumSize:
                              MaterialStateProperty.all(const Size(350, 50)),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const MyBottomNavigationBar(),
                            ),
                          );
                        },
                        child: const Text(
                          'เข้าสู่ระบบ',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: "prompt",
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Row(children: <Widget>[
                        Expanded(
                          child: Container(
                            margin:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: const Divider(
                              color: kTextColor,
                              height: 20,
                            ),
                          ),
                        ),
                        const Text(
                          "ยังไม่มีบัญชี ?",
                          style: TextStyle(
                            color: kTextColor,
                            fontSize: 15,
                            fontFamily: "prompt",
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: const Divider(
                              color: kTextColor,
                              height: 20,
                            ),
                          ),
                        ),
                      ]),
                      const SizedBox(
                        height: 15,
                      ),
                      TextButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(10)),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              kBackgroundColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          minimumSize:
                              MaterialStateProperty.all(const Size(350, 50)),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SignupScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'สมัครบัญชี',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: "prompt",
                          ),
                        ),
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
}
