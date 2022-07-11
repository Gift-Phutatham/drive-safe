import 'package:flutter/material.dart';

const kBackgroundColor = Color(0xFF51087E);
const kBoxColor = Color(0xFF6A2D94);
const kTextColor = Color(0xFF4B0082);
const kRedColor = Color(0xFFC7261C);
const kLightRedColor = Color(0xFFD86962);
const kOrangeColor = Color(0xFFEB781D);
const kLightOrangeColor = Color(0xFFED8C3E);
const kYellowColor = Color(0xFFF4B000);
const kLightYellowColor = Color(0xFFF5B40E);
const kTextStyle = TextStyle(fontFamily: 'Prompt', color: Colors.white);
const kTextStyle2 =
    TextStyle(fontFamily: 'Prompt', fontSize: 13, color: Colors.white);

class ApiConstants {
  static const String baseUrl = 'https://opend.data.go.th/get-ckan';
  static const String accidents2565Endpoint =
      '/datastore_search?resource_id=8d3e5a71-6114-461d-acb7-0d8857f78ad3';
  static const String accidents2564Endpoint =
      '/datastore_search?resource_id=4ace3123-0e93-497a-acb1-9d633779346c';
  static const String accidents2563Endpoint =
      '/datastore_search?resource_id=02c7f3e2-0262-4089-b7bf-de521833fc37';
}
