import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LocationService {
  final String key = dotenv.env["MAPS_API_KEY"]!;

  Future<String> getPlaceId(String input) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$key';

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var placeId = json['candidates'][0]['place_id'] as String;

    return placeId;
  }
}
