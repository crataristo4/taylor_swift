import 'package:flutter/material.dart';
import 'package:taylor_swift/enum/enums.dart';

class MenuInfo extends ChangeNotifier {
  DressType? dressType;
  String? title;
  String? imageSource;

  MenuInfo(this.dressType, {this.title, this.imageSource});

  updateMenu(MenuInfo menuInfo) {
    this.dressType = menuInfo.dressType;
    this.title = menuInfo.title;
    this.imageSource = menuInfo.imageSource;

//Important
    notifyListeners();
  }
}
