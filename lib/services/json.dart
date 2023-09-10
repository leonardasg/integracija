import 'dart:convert';

class Json {

  static String toJson(dynamic key, dynamic value) {
    Map<String, dynamic> jsonFormat = {};

    if (key is List && value is List) {
      for (int i = 0; i < key.length; i++) {
        if (value[i] is DateTime) {
          value[i] = value[i].toUtc().toIso8601String();
        }
        jsonFormat[key[i].toString()] = value[i];
      }
    } else if (key is String && value is String) {
      jsonFormat[key] = value;
    }

    return json.encode(jsonFormat);
  }

  static decode(data) {
    return json.decode(data);
  }

  static encode(data) {
    return json.encode(data);
  }
}