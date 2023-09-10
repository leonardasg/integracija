import 'dart:convert';
import 'package:crypto/crypto.dart';

class Hash {
  static String hashString(String input) {
    var bytes = utf8.encode(input); // convert input string to UTF-8 bytes
    var digest = sha256.convert(bytes); // hash the bytes using SHA-256
    return digest.toString(); // return the hash as a string
  }

  static String hashString2(String input) {
    var hashedPassword = utf8.encode(input).toString(); // convert input string to UTF-8 bytes
    var digest = base64.encode(utf8.encode(hashedPassword)); // hash the bytes using SHA-256
    return digest; // return the hash as a string
  }
}