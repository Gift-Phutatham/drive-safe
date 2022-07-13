import 'package:flutter/material.dart';

import 'constants.dart';
import 'my_bottom_navigation_bar.dart';

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
          children: [
            const SizedBox(
              height: 100,
            ),
            Image(image: AssetImage('assets/login_logo.png')),
            Expanded(
              child: FractionallySizedBox(
                heightFactor: 0.8,
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2),
                            ),
                            hintText: 'อีเมล',
                            hintStyle: TextStyle(
                              color: kTextColor,
                              fontSize: 15,
                              fontFamily: 'Prompt',
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20.0),
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.key),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 10),
                            ),
                            hintText: 'รหัสผ่าน',
                            hintStyle: TextStyle(
                              color: kTextColor,
                              fontSize: 15,
                              fontFamily: 'Prompt',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.all(10)),
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
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const MyBottomNavigationBar(),
                            ),
                          );
                        },
                        child: const Text('เข้าสู่ระบบ'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "ยังไม่มีบัญชี?",
                        style: TextStyle(
                          color: kTextColor,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.all(10)),
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
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const MyBottomNavigationBar(),
                            ),
                          );
                        },
                        child: const Text('สมัครบัญชี'),
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
