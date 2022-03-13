import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taylor_swift/constants/constants.dart';
import 'package:taylor_swift/ui/auth/config_page.dart';
import 'package:taylor_swift/ui/widgets/actions.dart';
import 'package:taylor_swift/ui/widgets/progress_dialog.dart';

import '../main.dart';

class Auth {

  login(loginData, context) {
    debugPrint('test');
    bool logged = false;
    try {
      Dialogs.showLoadingDialog(
        //show dialog and delay
          context,
          loadingKey,
          sendingCode,
          Colors.white70);
      FirebaseFirestore.instance.collection("users").get().then((value) {
        for(var item in value.docs){
          if (item.get('email').toString() == loginData['email'].toString()) {
            if (item.get('password').toString() == loginData['password'].toString()) {
              debugPrint('ssss');
              logged = true;
              FirebaseAuth.instance
                  .signInWithEmailAndPassword(email: loginData['email'].toString(),password: loginData['password'].toString())
                  .then((value) async {


                await Future.delayed(const Duration(seconds: 3));
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ConfigurationPage(),), (route) => false);
                debugPrint('ss');
              }).catchError((error){
                debugPrint('ssss  error $error');

              });

              break;



            } else
              debugPrint('invalid pass');
          }
          else
            debugPrint('invalid phone');
        }
        // value.docs.map((item) {
        //   if (item.get('phone').toString() == loginData['phone'].toString()) {
        //     if (item.get('password').toString() == loginData['password'].toString()) {
        //       debugPrint('ssss');
        //       if (item.get('email').toString() == loginData['email'].toString()) {
        //         debugPrint('ssss');
        //
        //
        //         FirebaseAuth.instance
        //             .signInWithEmailAndPassword(email: loginData['email'].toString(),password: loginData['password'].toString())
        //             .then((value) => debugPrint('ss')).catchError((error){
        //           debugPrint('ssss  error $error');
        //         });
        //         // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ConfigurationPage(),), (route) => false);
        //       } else
        //         debugPrint('invalid pass');
        //
        //
        //     } else
        //       debugPrint('invalid pass');
        //   }
        //   else
        //     debugPrint('invalid phone');
        // }).toList();
        debugPrint('value   ${value.docs.length}    $loginData');
        if(!logged){
          showFailure(context,'Wrong Credentials');
        }
      }).catchError((error) {
        showFailure(context,'Something went wrong');
        debugPrint('value  $error');
      });
    } on Exception catch (e) {
      // TODO
      showFailure(context,'Something went wrong');

      debugPrint('value  $e');
    }
    // FirebaseFirestore.instance
    //     .collection("users")
    //     .doc()
    //     .set(loginData)
    //     .catchError((onError) {
    //   showFailure(context, onError);
    // });
  }

  showFailure(context, error) {
    ShowAction().showToast(error, Colors.black);
    Navigator.of(context, rootNavigator: true).pop(); //close the dialog
  }
}
