import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  static const routeName = '/registration';

  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Register"),
      ),
    );
  }
}
