import 'package:rxdart/rxdart.dart';

import 'validator/login_validator.dart';

class LoginBloc extends Object with LoginValidator implements BaseBloc {
  final _phoneNumberController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Stream<String> get phoneNumberStream =>
      _phoneNumberController.stream.transform(validateNumber);

  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validatePass);

  Function(String) get onPhoneNumberChanged => _phoneNumberController.sink.add;

  Function(String) get onPasswordChanged => _passwordController.sink.add;

  ///@ method combinelastest1 was manually added to the  rx.dart api to support a single stream
  ///only use it for a single stream
  Stream<bool> get submitPhoneNumber =>
      Rx.combineLatest2(phoneNumberStream,passwordStream ,(value,value1) {
        print('test  $value $value1 ');
        return true;
      });


  @override
  void dispose() {
    _phoneNumberController.close();
    _passwordController.close();
  }
}

abstract class BaseBloc {
  void dispose();
}
