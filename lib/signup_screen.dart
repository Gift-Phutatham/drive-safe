import 'package:flutter/material.dart';

import 'constants.dart';
import 'login_screen.dart';

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
        color: kMainColor,
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
                                  color: kMainColor,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide:
                                      const BorderSide(color: kMainColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide:
                                      const BorderSide(color: kMainColor),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide:
                                      const BorderSide(color: kRedColor),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide:
                                      const BorderSide(color: kRedColor),
                                ),
                                labelText: 'ชื่อบัญชี*',
                                labelStyle: const TextStyle(
                                  color: kMainColor,
                                  fontSize: 15,
                                ),
                                floatingLabelStyle: const TextStyle(
                                  color: kMainColor,
                                  fontSize: 20,
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
                                  color: kMainColor,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide:
                                      const BorderSide(color: kMainColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide:
                                      const BorderSide(color: kMainColor),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide:
                                      const BorderSide(color: kRedColor),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide:
                                      const BorderSide(color: kRedColor),
                                ),
                                labelText: 'อีเมล*',
                                labelStyle: const TextStyle(
                                  color: kMainColor,
                                  fontSize: 15,
                                ),
                                floatingLabelStyle: const TextStyle(
                                  color: kMainColor,
                                  fontSize: 20,
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
                                  color: kMainColor,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide:
                                      const BorderSide(color: kMainColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide:
                                      const BorderSide(color: kMainColor),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide:
                                      const BorderSide(color: kRedColor),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide:
                                      const BorderSide(color: kRedColor),
                                ),
                                labelText: 'รหัสผ่าน*',
                                labelStyle: const TextStyle(
                                  color: kMainColor,
                                  fontSize: 15,
                                ),
                                floatingLabelStyle: const TextStyle(
                                  color: kMainColor,
                                  fontSize: 20,
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
                                        kMainColor),
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
                                        kMainColor),
                                side: MaterialStateProperty.all<BorderSide>(
                                  const BorderSide(color: kMainColor),
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
