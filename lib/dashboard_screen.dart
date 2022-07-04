import 'package:flutter/material.dart';
import 'constant.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "สถิติ",
          style: TextStyle(fontFamily: 'Prompt'),
        ),
        backgroundColor: kBackgroundColor,
      ),
      body: Container(),
    );
  }
}
