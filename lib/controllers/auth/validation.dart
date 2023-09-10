import 'package:email_validator/email_validator.dart';

import '../../models/member.dart';

class Validation {
  static String? defaultValidation(value) {
    if (value == null || value.isEmpty) {
      return 'Šis laukelis negali būt tuščias';
    }
    return null;
  }

  static String? stringValidation(value) {
    if (defaultValidation(value) == null) {
      final regex = RegExp(r'^[a-zA-ZĄąČčĘęĖėĮįŠšŲųŪūŽž\s-]+$');
      if (regex.hasMatch(value)) {
        return null;
      } else {
        return "Žodį turi sudaryti tik raidės";
      }
    } else {
      return defaultValidation(value);
    }
  }

  static String? mailValidation(value) {
    if (defaultValidation(value) == null) {
      if (EmailValidator.validate(value)) {
        return null;
      } else {
        return "El. paštas blogo formato";
      }
    } else {
      return defaultValidation(value);
    }
  }

  static String? passwordValidation(value) {
    if (defaultValidation(value) == null) {
      bool hasUppercase = false;
      bool hasDigits = false;
      bool hasLowercase = false;
      var character = '';
      var i = 0;

      while (i < value.length) {
        character = value.substring(i, i + 1);

        if (isDigit(character, 0)) {
          hasDigits = true;
        } else {
          if (character == character.toUpperCase()) {
            hasUppercase = true;
          }
          if (character == character.toLowerCase()) {
            hasLowercase = true;
          }
        }
        i++;
      }
      if (hasDigits & hasUppercase & hasLowercase) {
        return null;
      } else {
        return "Blogas slaptažodžio formatas";
      }
    } else {
      return defaultValidation(value);
    }
  }

  static String? passwordMatchValidation(value, secondValue) {
    if (defaultValidation(value) == null) {
      if (value == secondValue) {
        return null;
      } else {
        return "Slaptažodžiai nesutampa";
      }
    } else {
      return defaultValidation(value);
    }
  }

  static bool isDigit(String s, int idx) =>
      "0".compareTo(s[idx]) <= 0 && "9".compareTo(s[idx]) >= 0;

  static Future<String?> checkEmail(value) async {
    bool isTaken = await Member.checkEmail(value);
    if (isTaken) {
      return "Šiuo el. paštu jau yra registruota paskyra";
    }
    return null;
  }

}
