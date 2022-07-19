import 'package:flutter/material.dart';

import 'constants.dart';

class SecuritySettingBox extends StatefulWidget {
  const SecuritySettingBox({
    Key? key,
    required this.icon,
    required this.text,
    required this.route,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final Widget route;

  @override
  State<SecuritySettingBox> createState() => _SecuritySettingBoxState();
}

class _SecuritySettingBoxState extends State<SecuritySettingBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, StateSetter setState) {
              return widget.route;
            },
          );
        },
      ),
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        child: Row(
          children: [
            Icon(
              widget.icon,
              size: 30,
              color: kMainColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              widget.text,
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
