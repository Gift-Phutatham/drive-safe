import 'package:flutter/material.dart';

class PrivacySettingBox extends StatelessWidget {
  const PrivacySettingBox({Key? key, required this.icon, required this.text})
      : super(key: key);

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: Row(
        children: [
          Icon(
            icon,
            size: 30,
            color: Colors.purple,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: TextStyle(
              fontFamily: 'Prompt',
            ),
          ),
          SizedBox(
            width: 180,
          ),
          Icon(Icons.arrow_forward_ios_outlined),
        ],
      ),
    );
  }
}
