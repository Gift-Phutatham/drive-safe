import 'package:flutter/material.dart';

import 'constants.dart';
import 'privacy_setting_box.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "บัญชีของฉัน",
          style: TextStyle(fontFamily: 'Prompt'),
        ),
        backgroundColor: kBackgroundColor,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
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
                icon: Icons.account_circle_outlined, text: "เปลี่ยนชื่อบัญชี"),
            Divider(
              color: Colors.grey,
            ),
            PrivacySettingBox(
                icon: Icons.lock_outline_rounded, text: "เปลี่ยนรหัสผ่าน"),
            SizedBox(
              height: 150,
            ),
            Container(
              width: 322,
              height: 59,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: kBackgroundColor,
                  width: 1,
                ),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.logout),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'ออกจากระบบ',
                    style: TextStyle(
                      fontFamily: 'Prompt',
                      fontSize: 16,
                      color: Colors.black,
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
}
