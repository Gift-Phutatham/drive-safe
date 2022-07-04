import 'package:http/http.dart' as http;

import 'constants.dart';
import 'record_model.dart';

class ApiService {
  Future<RecordModel?> getUsers() async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.accidents2565Endpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        RecordModel _model = recordModelFromJson(response.body);
        return _model;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
