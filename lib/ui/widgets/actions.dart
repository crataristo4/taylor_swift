import 'dart:ui';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taylor_swift/constants/constants.dart';
import 'package:taylor_swift/helper/notification_info.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';

class ShowAction {
  static void scheduleNotification(
      scheduledNotificationDateTime, NotificationInfo notificationInfo) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'notification',
      'notification',
      'Channel for Notification',
      importance: Importance.high,
      icon: 'launch_image', //todo -- change
      sound: RawResourceAndroidNotificationSound('notif'),
      largeIcon: DrawableResourceAndroidBitmap('launch_image'),
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        sound: 'notif.mp3',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(
      0,
      notificationInfo.title,
      "Is due!",
      scheduledNotificationDateTime,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
    );
  }

  void showSnackbar(BuildContext context, String message) {
    SnackBar snackBar = SnackBar(
      content: Text(message),
      padding: EdgeInsets.all(eightDp),
      backgroundColor: Theme.of(context).primaryColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showToast(message, Color color) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: sixteenDp);
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(anErrorOccurred),
        content: Text(message),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text(OK),
          )
        ],
      ),
    );
  }

  static void showAlertDialog(String title, String content,
      BuildContext context, Widget widgetA, Widget widgetB) {
    var alertDialog = AlertDialog(
      title: Text(title),
      content: Text(content),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      actions: <Widget>[widgetA, widgetB],
    );

    showDialog(
      context: context,
      builder: (_) => alertDialog,
      barrierDismissible: true,
    );
  }

  static void showDetails(
      String title, String content, BuildContext context, Widget widgetA) {
    var alertDialog = AlertDialog(
      title: Text(title),
      content: Text(content),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      actions: <Widget>[widgetA],
    );

    showDialog(
      context: context,
      builder: (_) => alertDialog,
      barrierDismissible: true,
    );
  }

  static Future<void> makePhoneCall(String? url) async {
    if (await canLaunch(url!)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<void> launchURL(String url) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      if (await canLaunch(url)) {
        await launch(
          url,
          forceWebView: false,
        );
      } else {
        ShowAction().showToast("Could not launch url", Colors.black);
      }
    } else {
      ShowAction().showToast(unableToConnect, Colors.black);
    }
  }
}
