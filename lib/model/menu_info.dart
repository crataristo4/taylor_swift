import 'package:flutter/material.dart';
import 'package:taylor_swift/constants/constants.dart';
import 'package:taylor_swift/enum/enums.dart';

class MenuInfo extends ChangeNotifier {
  DressType? dressType;
  String? title;
  String? imageSource;

  MenuInfo(this.dressType, {this.title, this.imageSource});

  updateMenu(MenuInfo? menuInfo) {
    this.dressType = menuInfo!.dressType;
    this.title = menuInfo.title;
    this.imageSource = menuInfo.imageSource;

//Important
    notifyListeners();
  }
}

List<MenuInfo> menuItems = [
  MenuInfo(DressType.LADIES_DRESS,
      title: ld, imageSource: 'assets/images/ld.png'),
  MenuInfo(DressType.LADIES_SKIRT,
      title: ls, imageSource: 'assets/images/lsk.png'),
  MenuInfo(DressType.LADIES_TOP,
      title: lt, imageSource: 'assets/images/lshirt.png'),
  MenuInfo(DressType.LADIES_TOP,
      title: ltr, imageSource: 'assets/images/lt.png'),
  MenuInfo(DressType.LADIES_TOP,
      title: md, imageSource: 'assets/images/md.png'),
  MenuInfo(DressType.LADIES_TOP,
      title: ms, imageSource: 'assets/images/mshots.png'),
  MenuInfo(DressType.LADIES_TOP,
      title: mt, imageSource: 'assets/images/mshirt.png'),
  MenuInfo(DressType.LADIES_TOP,
      title: mtr, imageSource: 'assets/images/mt.png'),
];
