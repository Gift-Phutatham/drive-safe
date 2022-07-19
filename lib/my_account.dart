import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drive_safe/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'security_setting_box.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  late FirebaseAuth _auth;
  late FirebaseFirestore _firestore;
  late String loggedInUser;
  late User? currUser;

  final _formKey = GlobalKey<FormState>();

  String newAccountNameLabelText = 'ชื่อบัญชีใหม่';
  String newPasswordLabelText = 'รหัสผ่านใหม่';
  String newPasswordConfirmedLabelText = 'ยืนยันรหัสผ่านใหม่';

  String newAccountName = '';
  String newPassword = '';
  String newPasswordConfirmed = '';

  String error = '';

  @override
  void initState() {
    super.initState();
    initFirebase();
  }

  void initFirebase() async {
    _auth = FirebaseAuth.instance;
    _firestore = FirebaseFirestore.instance;
    currUser = _auth.currentUser;
    loggedInUser = currUser?.email ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 25,
              ),
              const Image(
                image: AssetImage(
                  'assets/blank-profile-picture.png',
                ),
                width: 100,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "สวัสดี",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection(kAccountNameCollection)
                    .where('email', isEqualTo: loggedInUser)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    final snap = snapshot.data!.docs;
                    return ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: snap.length,
                      itemBuilder: (context, index) {
                        return Text(
                          snap[index]['accountName'],
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.center,
                        );
                      },
                    );
                  } else {
                    return const Text('');
                  }
                },
              ),
              const SizedBox(
                height: 7.5,
              ),
              Text(
                loggedInUser,
                style: const TextStyle(
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: const Text(
                  "ความปลอดภัย",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SecuritySettingBox(
                icon: Icons.account_circle_outlined,
                text: "เปลี่ยนชื่อบัญชี",
                route: getAccountDialog(),
              ),
              const Divider(
                color: Colors.grey,
              ),
              SecuritySettingBox(
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
              const SizedBox(
                height: 20,
              ),
            ],
          ),
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

  Widget getTextFormField(String labelText) {
    return SizedBox(
      width: 350,
      height: 80,
      child: TextFormField(
        decoration: InputDecoration(
          enabledBorder: getBorder(kMainColor),
          focusedBorder: getBorder(kMainColor),
          errorBorder: getBorder(kRedColor),
          focusedErrorBorder: getBorder(kRedColor),
          labelText: '$labelText*',
          labelStyle: const TextStyle(
            fontSize: 15,
          ),
          floatingLabelStyle: const TextStyle(
            color: kMainColor,
            fontSize: 20,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          errorStyle: const TextStyle(height: 0.75),
        ),
        obscureText: labelText.contains('รหัสผ่าน'),
        onChanged: (value) {
          if (labelText == newAccountNameLabelText) {
            newAccountName = value;
          } else if (labelText == newPasswordLabelText) {
            newPassword = value;
          } else if (labelText == newPasswordConfirmedLabelText) {
            newPasswordConfirmed = value;
          }
        },
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return 'กรุณากรอก$labelText';
          }
          return null;
        },
      ),
    );
  }

  Widget getTextButton(
    String text,
    Color foregroundColor,
    Color backgroundColor,
    int category,
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
      onPressed: () async {
        if (validate) {
          if (_formKey.currentState!.validate()) {
            if (category == 0) {
              final messages = await _firestore
                  .collection(kAccountNameCollection)
                  .where('email', isEqualTo: loggedInUser)
                  .get();
              for (var message in messages.docs) {
                final data = {'accountName': newAccountName};
                _firestore
                    .collection(kAccountNameCollection)
                    .doc(message.id)
                    .set(data, SetOptions(merge: true));
              }
              Navigator.of(context).pop();
            } else {
              if (newPassword == newPasswordConfirmed) {
                currUser?.updatePassword(newPassword).then((_) {
                  Navigator.of(context).pop();
                }).catchError((e) {
                  setState(() {
                    error = 'เปลี่ยนรหัสผ่านใหม่ไม่สำเร็จ กรุณาลองอีกครั้ง';
                  });
                });
              } else {
                setState(() {
                  error = 'รหัสผ่านใหม่ไม่ตรงกับยืนยันรหัสผ่านใหม่';
                });
              }
            }
          }
        } else {
          Navigator.of(context).pop();
          setState(() {
            error = '';
          });
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

  Widget getAccountDialog() {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(10),
      titlePadding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: const EdgeInsets.only(bottom: 15),
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
      content: SizedBox(
        height: 105,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              getTextFormField(newAccountNameLabelText),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            getTextButton(
              'บันทึก',
              Colors.white,
              kMainColor,
              0,
              true,
            ),
            const SizedBox(
              width: 10,
            ),
            getTextButton(
              'ยกเลิก',
              kMainColor,
              Colors.white,
              0,
              false,
            ),
          ],
        ),
      ],
    );
  }

  Widget getPasswordDialog() {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(10),
      titlePadding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: const EdgeInsets.only(bottom: 15),
      title: Container(
        width: 500,
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
          'เปลี่ยนรหัสผ่าน',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      content: SizedBox(
        width: 700,
        height: 210,
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 25,
              ),
              getTextFormField(newPasswordLabelText),
              getTextFormField(newPasswordConfirmedLabelText),
              if (error != '')
                Text(
                  error,
                  style: const TextStyle(
                    color: kRedColor,
                    fontSize: 15,
                  ),
                ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            getTextButton(
              'บันทึก',
              Colors.white,
              kMainColor,
              1,
              true,
            ),
            const SizedBox(
              width: 10,
            ),
            getTextButton(
              'ยกเลิก',
              kMainColor,
              Colors.white,
              1,
              false,
            ),
          ],
        ),
      ],
    );
  }
}
