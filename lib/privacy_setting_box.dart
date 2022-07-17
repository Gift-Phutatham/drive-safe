import 'package:flutter/material.dart';

import 'constants.dart';

class PrivacySettingBox extends StatelessWidget {
  const PrivacySettingBox({
    Key? key,
    required this.icon,
    required this.text,
    required this.route,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final Widget route;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => route,
      ),
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        child: Row(
          children: [
            Icon(
              icon,
              size: 30,
              color: kBackgroundColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: const TextStyle(
                fontFamily: 'Prompt',
              ),
            ),
            const SizedBox(
              width: 180,
            ),
            const Icon(Icons.arrow_forward_ios_outlined),
          ],
        ),
      ),
    );
  }
}
