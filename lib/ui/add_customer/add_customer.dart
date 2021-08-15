import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taylor_swift/constants/constants.dart';
import 'package:taylor_swift/constants/theme_data.dart';
import 'package:taylor_swift/enum/enums.dart';
import 'package:taylor_swift/model/menu_info.dart';
import 'package:taylor_swift/ui/home/home.dart';
import 'package:taylor_swift/ui/pages/ladies/ladies_dress.dart';
import 'package:taylor_swift/ui/pages/ladies/ladies_skirt.dart';
import 'package:taylor_swift/ui/pages/ladies/ladies_top.dart';
import 'package:taylor_swift/ui/pages/ladies/ladies_trouser.dart';
import 'package:taylor_swift/ui/pages/mens/mens_dress.dart';
import 'package:taylor_swift/ui/pages/mens/mens_top.dart';
import 'package:taylor_swift/ui/pages/mens/mens_trouser_shorts.dart';

class AddCustomer extends StatefulWidget {
  static const routeName = '/addCustomer';

  final selectedMonth;

  const AddCustomer({Key? key, this.selectedMonth}) : super(key: key);

  @override
  _AddCustomerState createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          // toolbarHeight: 0,
          centerTitle: true,
          title: Text(
            addNew,
            style: TextStyle(fontSize: eighteenDp),
          ),
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          leading: InkWell(
            onTap: () => Navigator.of(context)
                .pushNamedAndRemoveUntil(HomePage.routeName, (route) => false),
            child: Container(
              margin: EdgeInsets.all(tenDp),
              decoration: BoxDecoration(
                  border: Border.all(width: 0.3, color: Colors.grey),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(thirtyDp)),
              child: Padding(
                padding: EdgeInsets.all(eightDp),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.grey,
                  size: sixteenDp,
                ),
              ),
            ),
          ),
        ),
        body: Row(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: menuItems
                    .map((currentMenuInfo) => buildMenuButton(currentMenuInfo))
                    .toList(),
              ),
            ),
            VerticalDivider(
              color: CustomColors.dividerColor,
              width: 1,
            ),
            Expanded(
              child: Consumer<MenuInfo>(
                builder:
                    (BuildContext context, MenuInfo? value, Widget? child) {
                  switch (value!.dressType) {
                    case DressType.LADIES_DRESS:
                      return LadiesDress(
                        month: widget.selectedMonth,
                      );
                    case DressType.LADIES_SKIRT:
                      return LadiesSkirt(month: widget.selectedMonth);
                    case DressType.LADIES_TOP:
                      return LadiesTop(
                        month: widget.selectedMonth,
                      );
                    case DressType.LADIES_TROUSER:
                      return LadiesTrouser(month: widget.selectedMonth);

                    case DressType.MENS_DRESS:
                      return MensDress(
                        month: widget.selectedMonth,
                      );
                    /*  case DressType.MENS_SHORTS:
                      return MensShorts();*/
                    case DressType.MENS_TOP:
                      return MensTop(
                        month: widget.selectedMonth,
                      );

                    case DressType.MENS_TROUSER:
                      return MensTrouserOrShorts(month: widget.selectedMonth);

                    default:
                      return Container(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(fontSize: 20),
                            children: <TextSpan>[
                              TextSpan(text: 'NOT AVAILABLE\n'),
                              TextSpan(
                                text: value.title,
                                style: TextStyle(fontSize: 48),
                              ),
                            ],
                          ),
                        ),
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuButton(MenuInfo? currentMenuInfo) {
    return Consumer<MenuInfo>(
      builder: (BuildContext context, MenuInfo? value, Widget? child) {
        return FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.only(topRight: Radius.circular(thirtyTwoDp))),
          padding:
              const EdgeInsets.symmetric(vertical: sixteenDp, horizontal: 0),
          color: currentMenuInfo!.dressType == value!.dressType
              ? CustomColors.menuBackgroundColor
              : Colors.transparent,
          onPressed: () {
            var menuInfo = Provider.of<MenuInfo>(context, listen: false);
            menuInfo.updateMenu(currentMenuInfo);
          },
          child: Column(
            children: <Widget>[
              Image.asset(
                "${currentMenuInfo.imageSource}",
                scale: 2.5,
              ),
              SizedBox(height: twelveDp),
              Text(
                currentMenuInfo.title ?? '',
                style: TextStyle(
                    fontFamily: 'avenir',
                    color: CustomColors.primaryTextColor,
                    fontSize: 12),
              ),
            ],
          ),
        );
      },
    );
  }
}
