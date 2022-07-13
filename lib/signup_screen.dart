import 'package:flutter/material.dart';

import 'constants.dart';
import 'my_bottom_navigation_bar.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        color: kBackgroundColor,
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 75,
            ),
            const Image(
              image: AssetImage('assets/signup-logo.png'),
              height: 225,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: const Text(
                "สมัครบัญชี",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontFamily: 'Prompt',
                ),
                textAlign: TextAlign.right,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: FractionallySizedBox(
                heightFactor: 1,
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
                        height: 50,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.person,
                              color: kTextColor,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            hintText: 'ชื่อบัญชี',
                            hintStyle: const TextStyle(
                              color: kTextColor,
                              fontSize: 15,
                              fontFamily: 'Prompt',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.email,
                              color: kTextColor,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            hintText: 'อีเมล',
                            hintStyle: const TextStyle(
                              color: kTextColor,
                              fontSize: 15,
                              fontFamily: 'Prompt',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.key,
                              color: kTextColor,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            hintText: 'รหัสผ่าน',
                            hintStyle: const TextStyle(
                              color: kTextColor,
                              fontSize: 15,
                              fontFamily: 'Prompt',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
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
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const MyBottomNavigationBar(),
                            ),
                          );
                        },
                        child: const Text('สร้างบัญชี'),
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