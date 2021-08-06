import 'dart:ui';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taylor_swift/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ShowAction {
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
