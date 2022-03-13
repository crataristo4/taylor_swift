import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taylor_swift/constants/constants.dart';
import 'package:taylor_swift/model/dress.dart';
import 'package:taylor_swift/ui/widgets/actions.dart';

class DressService {
  final dressService = FirebaseFirestore.instance;
  FirebaseAuth mAuth = FirebaseAuth.instance;
  String? uid;

  //get dress list
  Stream<List<Dress>> fetchDress() {
    if (mAuth.currentUser != null) {
      uid = mAuth.currentUser!.uid;
      print('user id $uid');
    }
    return dressService
        .collection(dbShop)
        .doc(uid)
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
    if (mAuth.currentUser != null) {
      uid = mAuth.currentUser!.uid;
    }
    return dressService
        .collection(dbShop)
        .doc(uid)
        .collection(dbDress)
        .doc(dress.id)
        .set(dress.toMap())
        .catchError((onError) {
      showFailure(context, onError);
    });
  }

  //delete dress item
  Future<void> deleteMeasurement(String id) {
    if (mAuth.currentUser != null) {
      uid = mAuth.currentUser!.uid;
    }
    return dressService
        .collection(dbShop)
        .doc(uid)
        .collection(dbDress)
        .doc(id)
        .delete();
  }

  //update dress complete
  Future<void> updateWorkComplete(String id) {
    if (mAuth.currentUser != null) {
      uid = mAuth.currentUser!.uid;
    }
    return dressService
        .collection(dbShop)
        .doc(uid)
        .collection(dbDress)
        .doc(id)
        .update({'isComplete': true});
  }

  // FORCE update dress complete
  Future<void> forceUpdateWorkComplete(
      String id, String time, int serviceCharge) {
    if (mAuth.currentUser != null) {
      uid = mAuth.currentUser!.uid;
    }
    return dressService
        .collection(dbShop)
        .doc(uid)
        .collection(dbDress)
        .doc(id)
        .update({
      'isComplete': true,
      'dueDate': time,
      'initialPayment': serviceCharge
    });
  }

  showSuccess(context) {
    Future.delayed(Duration(seconds: 3));
    ShowAction().showToast(successful, Colors.black); //show complete msg
    Navigator.of(context, rootNavigator: true).pop();
    Navigator.of(context).pop();

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
