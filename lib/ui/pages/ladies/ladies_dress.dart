import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:taylor_swift/constants/constants.dart';
import 'package:taylor_swift/constants/theme_data.dart';
import 'package:taylor_swift/enum/enums.dart';
import 'package:taylor_swift/model/dress.dart';
import 'package:taylor_swift/provider/dress_provider.dart';
import 'package:taylor_swift/ui/home/home.dart';
import 'package:taylor_swift/ui/widgets/actions.dart';
import 'package:taylor_swift/ui/widgets/custom_dt_payment.dart';
import 'package:taylor_swift/ui/widgets/custom_inputs.dart';
import 'package:taylor_swift/ui/widgets/custom_name.dart';
import 'package:taylor_swift/ui/widgets/item_rows.dart';

class LadiesDress extends StatefulWidget {
  final month;

  const LadiesDress({Key? key, required this.month}) : super(key: key);

  @override
  _LadiesDressState createState() => _LadiesDressState();
}

class _LadiesDressState extends State<LadiesDress> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController waistController = TextEditingController();
  TextEditingController bustController = TextEditingController();
  TextEditingController hipController = TextEditingController();
  TextEditingController shoulderController = TextEditingController();
  TextEditingController nipToNipController = TextEditingController();
  TextEditingController shoToNipController = TextEditingController();
  TextEditingController shoToWaistController = TextEditingController();
  TextEditingController kneeController = TextEditingController();
  TextEditingController dressLengthController = TextEditingController();
  TextEditingController trouserLengthController = TextEditingController();
  TextEditingController sleeveLengthController = TextEditingController();
  TextEditingController aroundArmController = TextEditingController();
  TextEditingController dtController = TextEditingController();
  TextEditingController initialPaymentController = TextEditingController();
  TextEditingController serviceChargeController = TextEditingController();
  DressProvider _dressProvider = DressProvider();
  final _formKey = GlobalKey<FormState>();

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
                    TypewriterAnimatedText(dressMeasurement,
                        textStyle: TextStyle(
                            color: Colors.indigo, fontSize: fourteenDp)),
                  ],
                ),
              )),

              //first row fow measurement
              ItemRows(
                widgetA: CustomerInputs(
                  valueController: shoulderController,
                  imageSource: 'assets/images/shoda.png',
                  name: shoulder,
                  textColor: CustomColors.c6,
                ),
                widgetB: CustomerInputs(
                  valueController: bustController,
                  imageSource: 'assets/images/bust.png',
                  name: bust,
                  textColor: CustomColors.c4,
                ),
              ),

              //second row for measurement
              ItemRows(
                widgetA: CustomerInputs(
                  valueController: nipToNipController,
                  imageSource: 'assets/images/nipple.png',
                  name: nippleToNipple,
                  textColor: CustomColors.c7,
                ),
                widgetB: CustomerInputs(
                  valueController: shoToNipController,
                  imageSource: 'assets/images/shoToNip.png',
                  name: shoulderToNipple,
                  textColor: CustomColors.c1,
                ),
              ),

              //third row .
              ItemRows(
                widgetA: CustomerInputs(
                  valueController: hipController,
                  imageSource: 'assets/images/hip.png',
                  name: hip,
                  textColor: CustomColors.c2,
                ),
                widgetB: CustomerInputs(
                  valueController: waistController,
                  imageSource: 'assets/images/waist.png',
                  name: waist,
                  textColor: CustomColors.c1,
                ),
              ),
              //fourth row .
              ItemRows(
                widgetA: CustomerInputs(
                  valueController: shoToWaistController,
                  imageSource: 'assets/images/shoToWaist.png',
                  name: shoulderToWaist,
                  textColor: CustomColors.c4,
                ),
                widgetB: CustomerInputs(
                  valueController: kneeController,
                  imageSource: 'assets/images/knee.png',
                  name: knee,
                  textColor: CustomColors.c6,
                ),
              ),
              //fifth row .
              ItemRows(
                widgetA: CustomerInputs(
                  valueController: dressLengthController,
                  imageSource: 'assets/images/dress.png',
                  name: dressLength,
                  textColor: CustomColors.c1,
                ),
                widgetB: CustomerInputs(
                  valueController: sleeveLengthController,
                  imageSource: 'assets/images/sleeve.png',
                  name: sleeveLength,
                  textColor: CustomColors.c4,
                ),
              ),

              ItemRows(
                widgetA: CustomerInputs(
                  valueController: aroundArmController,
                  imageSource: 'assets/images/arm.png',
                  name: aroundArm,
                  textColor: CustomColors.c6,
                ),
                widgetB: CustomerInputs(
                  valueController: trouserLengthController,
                  imageSource: 'assets/images/lt.png',
                  name: trouserLength,
                  textColor: CustomColors.c4,
                ),
              ),

              CustomDtPmt(
                dateTimeController: dtController,
                paymentController: initialPaymentController,
                serviceChargeController: serviceChargeController,
              ),

              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: FloatingActionButton.extended(
                      label: Text(save),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          var status = Dress.checkPaymentStatus(
                              int.parse(serviceChargeController.text),
                              int.parse(initialPaymentController.text));

                          if (status.contains(error)) {
                            ShowAction().showSnackbar(context);
                          } else {
                            _dressProvider.setLadiesDressData(
                              nameController.text,
                              "${CustomNameAndNumber.cc}${phoneNumberController.text}",
                              shoulderController.text,
                              bustController.text,
                              nipToNipController.text,
                              shoToNipController.text,
                              hipController.text,
                              waistController.text,
                              shoToWaistController.text,
                              kneeController.text,
                              dressLengthController.text,
                              sleeveLengthController.text,
                              aroundArmController.text,
                              widget.month,
                              int.parse(serviceChargeController.text),
                              int.parse(initialPaymentController.text),
                              dtController.text,
                              trouserLengthController.text,
                            );

                            HomePage.nameControllerString = nameController.text;

                            _dressProvider.createNewDress(
                                context, DressType.LADIES_DRESS);

                            //call static method and schedule
                            HomePage.saveNotification();
                          }
                        }
                      }),
                ),
              )
            ],
          ),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

/*  Row ItemRows(Widget widgetA, Widget widgetB) {
    return Row(
      //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [widgetA, widgetB],
    );
  }*/
}
