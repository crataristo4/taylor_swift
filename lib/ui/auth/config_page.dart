import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taylor_swift/ui/auth/registration_page.dart';
import 'package:taylor_swift/ui/home/home.dart';

String? uid;

class ConfigurationPage extends StatefulWidget {
  static const routeName = '/';

  const ConfigurationPage({Key? key}) : super(key: key);

  @override
  _ConfigurationPageState createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  bool? isLoggedIn;

  @override
  void initState() {
    var user = Provider.of<User?>(context, listen: false);
    isLoggedIn = user != null;
    //uid = user!.uid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Container(
        child: SafeArea(
            top: false,
            bottom: false,
            child: Scaffold(
                body: isLoggedIn! ? HomePage() : RegistrationPage())),
      ),
    );
  }
}
