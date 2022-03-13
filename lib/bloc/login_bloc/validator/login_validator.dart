import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:taylor_swift/constants/constants.dart';

mixin LoginValidator {
  var validateNumber = StreamTransformer<String, String>.fromHandlers(
      handleData: (phoneNumber, sink) {
    if (phoneNumber.length >= 9 && !phoneNumber.toString().startsWith('0')) {
      sink.add(phoneNumber);
    } else if (phoneNumber.toString().startsWith('0')) {
      sink.addError(nonZero);
    } else {
      sink.addError(invalidPhone);
    }
  });
  var validatePass = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) async {
    if (password.length >= 4) {
      sink.add(password);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("pass", password);
    } else {
      sink.addError(invalidPassword);
    }
  });

}
