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
          style: TextStyle(fontFamily: 'Prompt'),
        ),
        backgroundColor: kBackgroundColor,
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
                fontFamily: 'Prompt',
                fontSize: 24,
              ),
            ),
            const Text(
              "คุณแนน",
              style: TextStyle(
                fontFamily: 'Prompt',
                fontSize: 24,
              ),
            ),
            const Text(
              "nannnyy16@gmail.com",
              style: TextStyle(
                fontFamily: 'Prompt',
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
                  fontFamily: 'Prompt',
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
                  color: kBackgroundColor,
                ),
                shadowColor: kBackgroundColor,
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
                    color: kBackgroundColor,
                    size: 24.0,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'ออกจากระบบ',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: "prompt",
                      color: kTextColor,
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
          color: kBackgroundColor,
        ),
        child: const Text(
          'เปลี่ยนชื่อบัญชี',
          style: TextStyle(
            fontFamily: 'Prompt',
            color: Colors.white,
          ),
        ),
      ),
      content: Column(
        children: <Widget>[
          Form(
            key: _formKey,
            child: TextFormField(
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                hintText: "ชื่อบัญชีใหม่",
                hintStyle: const TextStyle(
                  fontFamily: "Prompt",
                ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "กรุณากรอกข้อมูลให้ครบถ้วน";
                }
                return null;
              },
            ),
          ),
        ],
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.all(10)),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor:
                    MaterialStateProperty.all<Color>(kBackgroundColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                minimumSize: MaterialStateProperty.all(const Size(100, 50)),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.of(context).pop();
                }
              },
              child: const Text(
                'สมัครบัญชี',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: "prompt",
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.all(10),
                ),
                foregroundColor:
                    MaterialStateProperty.all<Color>(kBackgroundColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                side: MaterialStateProperty.all<BorderSide>(
                  const BorderSide(color: kBackgroundColor),
                ),
                minimumSize: MaterialStateProperty.all(const Size(100, 50)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'ยกเลิก',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: "prompt",
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget getPasswordDialog() {
    return AlertDialog(
      title: const Text('AlertDialog Title'),
      content: SingleChildScrollView(
        child: ListBody(
          children: const <Widget>[
            Text('This is a demo alert dialog.'),
            Text('Would you like to approve of this message?'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Approve'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
