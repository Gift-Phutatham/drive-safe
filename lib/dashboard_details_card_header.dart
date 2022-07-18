import 'package:flutter/material.dart';

class CardHeader extends StatelessWidget {
  const CardHeader({
    Key? key,
    required this.themeColor,
    required this.text,
    required this.padding,
  }) : super(key: key);
  final EdgeInsets padding;
  final Color themeColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
        color: themeColor,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
