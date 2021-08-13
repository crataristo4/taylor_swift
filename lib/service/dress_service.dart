import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taylor_swift/constants/constants.dart';
import 'package:taylor_swift/model/dress.dart';
import 'package:taylor_swift/ui/auth/config_page.dart';
import 'package:taylor_swift/ui/home/home.dart';
import 'package:taylor_swift/ui/widgets/actions.dart';

class DressService {
  final dressService = FirebaseFirestore.instance;

  //get dress list
  Stream<List<Dress>> fetchDress() {
    return dressService
        .collection(dbShop)
        .doc(id)
        .collection(dbDress)
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map((snapshots) => snapshots.docs
            .map((document) => Dress.fromMap(document.data()))
            .toList(growable: true))
        .handleError((error) {
      print(error);
    });
  }

  //create new dress item
  Future<void> createNewDress(Dress dress, BuildContext context) {
    return dressService
        .collection(dbShop)
        .doc(uid)
        .collection(dbDress)
        .add(dress.toMap())
        .whenComplete(() async {
      showSuccess(context);
    }).catchError((onError) {
      showFailure(context, onError);
    });
  }

  //delete dress item
  Future<void> deleteDress(String dressId, BuildContext context) {
    return dressService
        .collection(dbShop)
        .doc(uid)
        .collection(dbDress)
        .doc(dressId)
        .delete()
        .whenComplete(() {
      showDeletingSuccess(context);
    });
  }

  showSuccess(context) async {
    ShowAction().showToast(successful, Colors.black); //show complete msg
    // Navigator.of(context, rootNavigator: true).pop();
    // Navigator.of(context).pop();

    //  Navigator.of(context).pushNamed(HomePage.routeName, arguments: true);
  }

  showDeletingSuccess(context) async {
    ShowAction().showToast(successful, Colors.black); //show complete msg
    Navigator.of(context, rootNavigator: true).pop();
  }

  showFailure(context, error) {
    ShowAction().showToast(error, Colors.black);
    Navigator.of(context, rootNavigator: true).pop(); //close the dialog
  }
}
