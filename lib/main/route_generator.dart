import 'package:flutter/material.dart';
import 'package:taylor_swift/ui/auth/config_page.dart';
import 'package:taylor_swift/ui/auth/registration_page.dart';
import 'package:taylor_swift/ui/auth/verification_page.dart';
import 'package:taylor_swift/ui/home/home.dart';
import 'package:taylor_swift/ui/onboarding/onboarding_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      //config page
      case ConfigurationPage.routeName:
        return MaterialPageRoute(builder: (_) => ConfigurationPage());

      //home page
      case HomePage.routeName:
        return MaterialPageRoute(builder: (_) => HomePage());

      //shows when user newly installs the application
      case OnboardingScreen.routeName:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());

      //screen to register new users / login
      case RegistrationPage.routeName:
        return MaterialPageRoute(builder: (_) => RegistrationPage());

      //verify users phone number
      case VerificationPage.routeName:
        final data = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => VerificationPage(
                  phoneNumber: data,
                ));

      default:
        return _errorRoute();
    }
  }

  //error page ..
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        body: Center(
          child: Text("Page not Found"),
        ),
      );
    });
  }
}
