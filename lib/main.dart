import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taylor_swift/enum/enums.dart';
import 'package:taylor_swift/provider/auth_provider.dart';
import 'package:taylor_swift/ui/onboarding/onboarding_screen.dart';

import 'main/route_generator.dart';
import 'model/menu_info.dart';
import 'ui/auth/config_page.dart';

int? onboardingPrefs;
final GlobalKey<State> loadingKey = new GlobalKey<State>();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  onboardingPrefs = prefs.getInt("onboarding");
  await prefs.setInt("onboarding", 1);

  //location notification

/*  var initializationSettingsAndroid =
      AndroidInitializationSettings('');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {});
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  });*/

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(TaylorSwift()));
}

class TaylorSwift extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //authentication
        ChangeNotifierProvider.value(value: AuthProvider()),

        ChangeNotifierProvider<MenuInfo>(
            create: (context) => MenuInfo(DressType.LADIES_DRESS)),

        StreamProvider<User?>.value(
          value: FirebaseAuth.instance.authStateChanges(),
          initialData: FirebaseAuth.instance.currentUser,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.blue,
        ),
        initialRoute: onboardingPrefs == 0 || onboardingPrefs == null
            ? OnboardingScreen
                .routeName //shows when app data is cleared or newly installed
            : ConfigurationPage.routeName,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
