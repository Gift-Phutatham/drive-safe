import 'package:flutter/material.dart';

import 'constants.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'สถานที่โปรด',
        ),
        backgroundColor: kMainColor,
      ),
      body: Column(
        children: const [
          ListTile(
            title: Text(
              'เดอะมอลล์งามวงศ์วาน',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: kMainColor,
              ),
            ),
            subtitle: Text(
              'ตําบลบางเขน หมู่ที่ 2 30/39-50 ถนนงามวงศ์วาน อำเภอเมืองนนทบุรี นนทบุรี 11000',
              style: TextStyle(
                fontSize: 13,
                color: kMainColor,
              ),
            ),
            trailing: Icon(
              Icons.delete,
              color: kMainColor,
            ),
          ),
          ListTile(
            title: Text(
              'มหาวิทยาลัยมหิดล',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: kMainColor,
              ),
            ),
            subtitle: Text(
              '999 ถนนพุทธมณฑลสาย 4 ตำบลศาลายา อำเภอพุทธมณฑล นครปฐม 73170',
              style: TextStyle(
                fontSize: 13,
                color: kMainColor,
              ),
            ),
            trailing: Icon(
              Icons.delete,
              color: kMainColor,
            ),
          ),
        ],
      ),
    );
  }
}
