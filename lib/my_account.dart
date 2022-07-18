import 'package:flutter/material.dart';

import 'constants.dart';
import 'login_screen.dart';
import 'privacy_setting_box.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "บัญชีฉัน",
        ),
        backgroundColor: kMainColor,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            const Image(
              image: AssetImage(
                'assets/blank-profile-picture.png',
              ),
              width: 100,
            ),
            const Text(
              "สวัสดี",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            const Text(
              "คุณแนน",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            const Text(
              "nannnyy16@gmail.com",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Divider(
              color: Colors.grey[400],
              thickness: 3.0,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: const Text(
                "ความปลอดภัย",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            PrivacySettingBox(
              icon: Icons.account_circle_outlined,
              text: "เปลี่ยนชื่อบัญชี",
              route: getAccountDialog(),
            ),
            const Divider(
              color: Colors.grey,
            ),
            PrivacySettingBox(
              icon: Icons.lock_outline_rounded,
              text: "เปลี่ยนรหัสผ่าน",
              route: getPasswordDialog(),
            ),
            const SizedBox(
              height: 150,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(350, 50),
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                side: const BorderSide(
                  color: kMainColor,
                ),
                shadowColor: kMainColor,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginScreen(),
                  ),
                );
              },
              child: Wrap(
                children: const <Widget>[
                  Icon(
                    Icons.logout,
                    color: kMainColor,
                    size: 24.0,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'ออกจากระบบ',
                    style: TextStyle(
                      fontSize: 15,
                      color: kMainColor,
                    ),
                  ),
                ],
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

  Widget getTextFormField(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SizedBox(
        width: 350,
        height: 80,
        child: TextFormField(
          decoration: InputDecoration(
            enabledBorder: getBorder(kMainColor),
            focusedBorder: getBorder(kMainColor),
            errorBorder: getBorder(kRedColor),
            focusedErrorBorder: getBorder(kRedColor),
            labelText: '$text*',
            labelStyle: const TextStyle(
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
        Navigator.of(context).pop();
      },
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }

  Widget getAccountDialog() {
    return AlertDialog(
      title: Container(
        width: 340,
        height: 70,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          color: kMainColor,
        ),
        child: const Text(
          'เปลี่ยนชื่อบัญชี',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      content: Column(
        children: <Widget>[
          Form(
            key: _formKey,
            child: getTextFormField('ชื่อบัญชีใหม่'),
          ),
        ],
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            getTextButton(
              'บันทึก',
              Colors.white,
              kMainColor,
              true,
            ),
            const SizedBox(
              width: 10,
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
    );
  }

  Widget getPasswordDialog() {
    return AlertDialog(
      title: Container(
        width: 340,
        height: 70,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          color: kMainColor,
        ),
        child: const Text(
          'เปลี่ยนชื่อบัญชี',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      content: Column(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                getTextFormField('รหัสผ่านปัจจุบัน'),
                getTextFormField('รหัสผ่านใหม่'),
                getTextFormField('ยืนยันรหัสผ่านใหม่'),
              ],
            ),
          ),
        ],
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            getTextButton(
              'บันทึก',
              Colors.white,
              kMainColor,
              true,
            ),
            const SizedBox(
              width: 10,
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
    );
  }
}
