import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:taylor_swift/constants/constants.dart';
import 'package:taylor_swift/constants/theme_data.dart';
import 'package:taylor_swift/enum/enums.dart';
import 'package:taylor_swift/helper/notification_info.dart';
import 'package:taylor_swift/model/dress.dart';
import 'package:taylor_swift/provider/dress_provider.dart';
import 'package:taylor_swift/ui/home/home.dart';
import 'package:taylor_swift/ui/widgets/actions.dart';
import 'package:taylor_swift/ui/widgets/custom_dt_payment.dart';
import 'package:taylor_swift/ui/widgets/custom_inputs.dart';
import 'package:taylor_swift/ui/widgets/custom_name.dart';
import 'package:taylor_swift/ui/widgets/item_rows.dart';

import '../../../main.dart';

class LadiesSkirt extends StatefulWidget {
  final month;

  const LadiesSkirt({Key? key, this.month}) : super(key: key);

  @override
  _LadiesSkirtState createState() => _LadiesSkirtState();
}

class _LadiesSkirtState extends State<LadiesSkirt> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController waistController = TextEditingController();
  TextEditingController hipController = TextEditingController();
  TextEditingController kneeController = TextEditingController();
  TextEditingController skirtLengthController = TextEditingController();
  TextEditingController dtController = TextEditingController();
  TextEditingController initialPaymentController = TextEditingController();
  TextEditingController serviceChargeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  DressProvider _dressProvider = DressProvider();
  DateTime? _notificationTime;

  @override
  void initState() {
    _notificationTime = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: tenDp,
              ),
              CustomNameAndNumber(
                nameController: nameController,
                phoneNumberController: phoneNumberController,
              ),
              SizedBox(
                height: tenDp,
              ),
              Center(
                  child: DefaultTextStyle(
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: twentyDp,
                    fontFamily: 'Agne',
                    color: Colors.black),
                child: AnimatedTextKit(
                  totalRepeatCount: 1,
                  animatedTexts: [
                    TypewriterAnimatedText(skirtMeasurement,
                        textStyle: TextStyle(
                            color: Colors.indigo, fontSize: fourteenDp)),
                  ],
                ),
              )),

              //first row fow measurement
              ItemRows(
                widgetA: CustomerInputs(
                  valueController: waistController,
                  imageSource: 'assets/images/waist.png',
                  name: waist,
                  textColor: CustomColors.c1,
                ),
                widgetB: CustomerInputs(
                  valueController: hipController,
                  imageSource: 'assets/images/hip.png',
                  name: hip,
                  textColor: CustomColors.c4,
                ),
              ),

              //second row fow measurement
              ItemRows(
                widgetA: CustomerInputs(
                  valueController: kneeController,
                  imageSource: 'assets/images/knee.png',
                  name: knee,
                  textColor: CustomColors.c1,
                ),
                widgetB: CustomerInputs(
                  valueController: skirtLengthController,
                  imageSource: 'assets/images/lsk.png',
                  name: skirtLength,
                  textColor: CustomColors.c4,
                ),
              ),

              ItemRows(widgetA: Container(), widgetB: Container()),

              CustomDtPmt(
                dateTimeController: dtController,
                paymentController: initialPaymentController,
                serviceChargeController: serviceChargeController,
              ),

              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: twentyDp, vertical: thirtyDp),
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        //_notificationTime = dtController.text as DateTime?;
                        var status = Dress().checkPaymentStatus(
                            int.parse(serviceChargeController.text),
                            int.parse(initialPaymentController.text));

                        if (status.contains(error)) {
                          ShowAction().showSnackbar(context);
                        } else {
                          _dressProvider.setLsData(
                              nameController.text,
                              "${CustomNameAndNumber.cc}${phoneNumberController.text}",
                              waistController.text,
                              hipController.text,
                              kneeController.text,
                              skirtLengthController.text,
                              widget.month,
                              int.parse(serviceChargeController.text),
                              int.parse(initialPaymentController.text),
                              dtController.text,
                              status);

                          HomePage.nameControllerString = nameController.text;

                          _dressProvider.createNewDress(
                              context, DressType.LADIES_SKIRT);

                          saveNotification();
                        }
                      }
                    },
                    label: Text(save),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

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

  static void saveNotification() {
    DateTime scheduleAlarmDateTime;
    if (HomePage.notificationTime.isAfter(DateTime.now()))
      scheduleAlarmDateTime = HomePage.notificationTime;
    else
      scheduleAlarmDateTime = HomePage.notificationTime.add(Duration(days: 1));

    var notificationInfo = NotificationInfo(
      notifDateTime: scheduleAlarmDateTime,
      title: 'Time to submit ${HomePage.nameControllerString}\'s cloth',
    );
    // _notificationHelper.insertNotification(notificationInfo);
    scheduleNotification(scheduleAlarmDateTime, notificationInfo);
    print("saved to $scheduleAlarmDateTime  ${HomePage.nameControllerString}");
  }
}
