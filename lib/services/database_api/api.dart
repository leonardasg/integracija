import 'package:http/http.dart' as http;
import '../json.dart';

class Api {

  static String url = 'http://127.0.0.1:4567/api';

  static Future<bool> checkAPIConnection() async {
    var response = await http.get(Uri.parse('$url/members'));
    if (response.statusCode == 200 && Json.decode(response.body)['message'] == null) {
      return true;
    }
    return false;
  }

  static Future<http.Response> get(String category) async {
    return await http.get(Uri.parse('$url$category'));
  }

  static Future<http.Response> post(String category, String jsonBody) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};

    return await http.post(Uri.parse('$url$category'),
        headers: headers, body: jsonBody);
  }

  static Future<http.Response> put(String category, String jsonBody) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};

    return await http.put(Uri.parse('$url$category'),
        headers: headers, body: jsonBody);
  }

  static Future<http.Response> delete(String category) async {
    return await http.delete(Uri.parse('$url$category'));
  }
}