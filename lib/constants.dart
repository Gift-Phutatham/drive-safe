import 'package:flutter/material.dart';

const kMainColor = Color(0xFF51087E);
const kRedColor = Color(0xFFC7261C);
final kLightRedColor = kRedColor.withOpacity(0.85);
const kOrangeColor = Color(0xFFEB781D);
final kLightOrangeColor = kOrangeColor.withOpacity(0.85);
const kYellowColor = Color(0xFFF4B000);
final kLightYellowColor = kYellowColor.withOpacity(0.85);
const kGreenColor = Color(0xFF08A87B);
const kFontFamily = 'Prompt';
const kAccountNameCollection = 'account name';
const kFavoriteCollection = 'favorite';

class ApiConstants {
  static const String baseUrl = 'https://opend.data.go.th/get-ckan';
  static const String accidents2565Endpoint =
      '/datastore_search?resource_id=8d3e5a71-6114-461d-acb7-0d8857f78ad3';
  static const String accidents2564Endpoint =
      '/datastore_search?resource_id=4ace3123-0e93-497a-acb1-9d633779346c';
  static const String accidents2563Endpoint =
      '/datastore_search?resource_id=02c7f3e2-0262-4089-b7bf-de521833fc37';
}
