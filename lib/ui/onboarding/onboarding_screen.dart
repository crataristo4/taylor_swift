import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  static const routeName = '/onboarding';

  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool? isLoggedIn;

  @override
  void initState() {
    var user = Provider.of<User?>(context, listen: false);
    isLoggedIn = user != null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(" ?? --- $isLoggedIn");
    return Scaffold(
      body: Center(child: Text("heyyyy")),
    );
  }
}
