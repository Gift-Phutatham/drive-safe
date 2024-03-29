import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'constants.dart';
import 'record_model.dart';

class ApiService {
  Future<RecordModel?> getRecord(String endpoint) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + endpoint);
      var response =
          await http.get(url, headers: {'api-key': dotenv.env['API_KEY']!});
      if (response.statusCode == 200) {
        RecordModel _model = recordModelFromJson(response.body);
        return _model;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<List<RecordModel?>?> getAllRecords() async {
    try {
      List<String> endpoint = [
        ApiConstants.accidents2563Endpoint,
        ApiConstants.accidents2564Endpoint,
        ApiConstants.accidents2565Endpoint
      ];
      List<RecordModel?> allRecords = [];
      for (String e in endpoint) {
        for (var i = 0; i < 10; i++) {
          RecordModel? _model = await getRecord('$e&offset=${i * 100}');
          allRecords.add(_model);
        }
      }
      print(allRecords.length);
      return allRecords;
    } catch (e) {
      print('error');
      print(e.toString());
    }
    return null;
  }
}
