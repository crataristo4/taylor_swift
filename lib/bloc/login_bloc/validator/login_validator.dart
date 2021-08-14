import 'dart:async';

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
}
