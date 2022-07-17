import 'package:drive_safe/login_screen.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        color: kBackgroundColor,
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 90,
            ),
            const Image(
              image: AssetImage('assets/signup-logo.png'),
              height: 200,
            ),
            const SizedBox(
              height: 40,
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
            Expanded(
              child: FractionallySizedBox(
                heightFactor: 0.97,
                alignment: Alignment.bottomCenter,
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
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: SizedBox(
                            width: 350,
                            height: 75,
                            child: TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: kTextColor,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                labelText: 'ชื่อบัญชี*',
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
                                errorStyle: const TextStyle(height: 0.75),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return "กรุณากรอกชื่อบัญชี";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: SizedBox(
                            width: 350,
                            height: 75,
                            child: TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: kTextColor,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                labelText: 'อีเมล*',
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
                                errorStyle: const TextStyle(height: 0.75),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return "กรุณากรอกอีเมล";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: SizedBox(
                            width: 350,
                            height: 75,
                            child: TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.key,
                                  color: kTextColor,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                labelText: 'รหัสผ่าน*',
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
                                errorStyle: const TextStyle(height: 0.75),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return "กรุณากรอกรหัสผ่าน";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TextButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.all(10)),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        kBackgroundColor),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                                minimumSize: MaterialStateProperty.all(
                                    const Size(165, 55)),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const LoginScreen(),
                                    ),
                                  );
                                }
                              },
                              child: const Text(
                                'สร้างบัญชี',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Prompt',
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            TextButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.all(10)),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        kBackgroundColor),
                                side: MaterialStateProperty.all<BorderSide>(
                                  const BorderSide(color: kBackgroundColor),
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                                minimumSize: MaterialStateProperty.all(
                                    const Size(165, 55)),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const LoginScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                'ยกเลิก',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Prompt',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
