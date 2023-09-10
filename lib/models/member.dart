import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/auth/hash.dart';
import '../services/database_api/api.dart';
import '../services/database_api/variables.dart';
import '../services/json.dart';

class Member extends  ChangeNotifier {
  bool guest = true;
  String id;
  String email;
  String firstname;
  String lastname;
  DateTime? dateOfBirth;
  String password;

  Member({
    this.id = '',
    this.email = '',
    this.firstname = '',
    this.lastname = '',
    this.dateOfBirth,
    this.password = '',
  });

  Future<bool> login(String email, String password) async {
    List<String> key = ['email', 'password'];
    List<String> values = [email, password];
    String jsonBody = Json.toJson(key, values);

    var response = await Api.post(checkUserLogin, jsonBody);

    if (response.statusCode == 200 && Json.decode(response.body)['message'] == null) {
      if (Json.decode(response.body)['valid']) {
        if (Json.decode(response.body)['obj'] != null) {
          Map<String, dynamic> obj = Json.decode(response.body)['obj'];
          id = obj['id'];
          this.email = obj['email'];
          firstname = obj['firstname'];
          lastname = obj['lastname'];
          dateOfBirth = DateTime.parse(obj['date_of_birth']);
          this.password = obj['password'];
          guest = false;
          notifyListeners();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('email', email);
          prefs.setString('password', password);
          return true;
        }
      }
      else {
        return false;
      }
    }
    return false;
  }

  void logout() async {
    guest = true;
    id = '';
    email = '';
    firstname = '';
    lastname = '';
    dateOfBirth = null;
    password = '';
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('password');
  }

  Future<void> checkForLoggedUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');
    if (email != null && password != null) {
      login(email, password);
    }
  }

  // static Future<String> addUser(User newUser) async {
  //   String jsonBody = Json.userToJson(newUser);
  //   var response = await Api.post(postUser, jsonBody);
  //
  //   if (response.statusCode == 200 && Json.decode(response.body)['message'] == null) {
  //     return Json.decode(response.body)['id'];
  //   }
  //   return '';
  // }

  // Future<bool> editUserData(User newUser) async {
  //   String jsonBody = Json.userToJson(newUser);
  //   var response = await Api.post(editUser, jsonBody);
  //
  //   if (response.statusCode == 200 &&
  //       Json.decode(response.body)['message'] == null &&
  //       newUser.id ==  Json.decode(response.body)['id'])
  //   {
  //     email = newUser.email;
  //     firstname = newUser.firstname;
  //     lastname = newUser.lastname;
  //     dateOfBirth = newUser.dateOfBirth;
  //     password = newUser.password;
  //     notifyListeners();
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     prefs.setString('email', email);
  //     prefs.setString('password', password);
  //     return true;
  //   }
  //   return false;
  // }

  static Future<bool> checkPassword(String email, String password) async {
    List<String> key = ['email', 'password'];
    List<String> values = [email, Hash.hashString(password)];
    String jsonBody = Json.toJson(key, values);

    var response = await Api.post(checkUserPassword, jsonBody);
    if (response.statusCode == 200 && Json.decode(response.body)['message'] == null) {
      if (Json.decode(response.body)['valid']) {
        return true;
      }
      else {
        return false;
      }
    }
    return false;
  }

  static Future<bool> checkEmail(String value) async {
    String key = 'email';
    String emailJson = Json.toJson(key, value);

    var response = await Api.post(checkUserEmail, emailJson);

    if (response.statusCode == 200 && Json.decode(response.body)['message'] == null) {
      return Json.decode(response.body)['exists'];
    }
    return false;
  }
}