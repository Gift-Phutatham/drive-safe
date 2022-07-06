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
          style: TextStyle(fontFamily: 'Prompt'),
        ),
        backgroundColor: kBackgroundColor,
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(
              'เดอะมอลล์งามวงศ์วาน',
              style: TextStyle(
                  fontFamily: 'Prompt',
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: kTextColor),
            ),
            subtitle: Text(
              'ตําบลบางเขน หมู่ที่ 2 30/39-50 ถนนงามวงศ์วาน อำเภอเมืองนนทบุรี นนทบุรี 11000',
              style: TextStyle(
                fontFamily: 'Prompt',
                fontSize: 13,
                color: kTextColor,
              ),
            ),
            trailing: Icon(
              Icons.delete,
              color: kBackgroundColor,
            ),
          ),
          ListTile(
            title: Text(
              'มหาวิทยาลัยมหิดล',
              style: TextStyle(
                  fontFamily: 'Prompt',
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: kTextColor),
            ),
            subtitle: Text(
              '999 ถนนพุทธมณฑลสาย 4 ตำบลศาลายา อำเภอพุทธมณฑล นครปฐม 73170',
              style: TextStyle(
                fontFamily: 'Prompt',
                fontSize: 13,
                color: kTextColor,
              ),
            ),
            trailing: Icon(
              Icons.delete,
              color: kBackgroundColor,
            ),
          ),
        ],
      ),
    );
  }
}
