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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 45,
                        ),
                        getTextFormField(
                          'ชื่อบัญชี',
                          Icons.person,
                        ),
                        getTextFormField(
                          'อีเมล',
                          Icons.email,
                        ),
                        getTextFormField(
                          'รหัสผ่าน',
                          Icons.key,
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
                              const LoginScreen(),
                              true,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            getTextButton(
                              'ยกเลิก',
                              kMainColor,
                              Colors.white,
                              const LoginScreen(),
                              false,
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

  InputBorder getBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: BorderSide(color: color),
    );
  }

  Widget getTextFormField(String text, IconData icon) {
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
            labelText: '$text*',
            labelStyle: const TextStyle(
              color: kMainColor,
              fontSize: 15,
            ),
            floatingLabelStyle: const TextStyle(
              color: kMainColor,
              fontSize: 20,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
            errorStyle: const TextStyle(height: 0.75),
          ),
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'กรุณากรอก$text';
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
    Widget route,
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
      onPressed: () {
        if (validate) {
          if (_formKey.currentState!.validate()) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => route,
              ),
            );
          }
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => route,
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
}
