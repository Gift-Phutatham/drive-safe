import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:drive_safe/record_model.dart';
import 'api_service.dart';

class DashboardDetailsScreen extends StatelessWidget {
  const DashboardDetailsScreen({required this.name, required this.records});
  final String name;
  final List<Record> records;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          name,
          style: const TextStyle(fontFamily: 'Prompt'),
        ),
        backgroundColor: kBackgroundColor,
      ),
    );
  }
}
