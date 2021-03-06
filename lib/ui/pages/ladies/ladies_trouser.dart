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

class LadiesTrouser extends StatefulWidget {
  final month;

  const LadiesTrouser({Key? key, required this.month}) : super(key: key);

  @override
  _LadiesTrouserState createState() => _LadiesTrouserState();
}

class _LadiesTrouserState extends State<LadiesTrouser> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController waistController = TextEditingController();
  TextEditingController hipController = TextEditingController();
  TextEditingController kneeController = TextEditingController();
  TextEditingController crouchController = TextEditingController();
  TextEditingController ankleController = TextEditingController();
  TextEditingController trouserLengthController = TextEditingController();
  TextEditingController dtController = TextEditingController();
  TextEditingController initialPaymentController = TextEditingController();
  TextEditingController serviceChargeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DressProvider _dressProvider = DressProvider();

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
                    TypewriterAnimatedText(ladiesTrouserMeasurement,
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
                  textColor: CustomColors.c2,
                ),
              ),

              //second row fow measurement
              ItemRows(
                widgetA: CustomerInputs(
                  valueController: crouchController,
                  imageSource: 'assets/images/crotch.png',
                  name: crotch,
                  textColor: CustomColors.c4,
                ),
                widgetB: CustomerInputs(
                  valueController: kneeController,
                  imageSource: 'assets/images/knee.png',
                  name: knee,
                  textColor: CustomColors.c6,
                ),
              ),

              //third row fow measurement
              ItemRows(
                widgetA: CustomerInputs(
                  valueController: ankleController,
                  imageSource: 'assets/images/ankle.png',
                  name: ankle,
                  textColor: CustomColors.c7,
                ),
                widgetB: CustomerInputs(
                  valueController: trouserLengthController,
                  imageSource: 'assets/images/lt.png',
                  name: trouserLength,
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
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        var status = Dress.checkPaymentStatus(
                            int.parse(serviceChargeController.text),
                            int.parse(initialPaymentController.text));

                        if (status.contains(error)) {
                          ShowAction()
                              .showSnackbar(context, payGreaterThanCharge);
                        } else {
                          _dressProvider.setLtrData(
                              nameController.text,
                              "${CustomNameAndNumber.cc}${phoneNumberController.text}",
                              trouserLengthController.text,
                              waistController.text,
                              hipController.text,
                              kneeController.text,
                              ankleController.text,
                              crouchController.text,
                              widget.month,
                              int.parse(serviceChargeController.text),
                              int.parse(initialPaymentController.text),
                              dtController.text);

                          HomePage.nameControllerString = nameController.text;

                          _dressProvider.createNewDress(
                              context, DressType.LADIES_TROUSER);

                          //call static method and schedule
                          HomePage.saveNotification();
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
}
