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

class MensTop extends StatefulWidget {
  final month;

  const MensTop({Key? key, this.month}) : super(key: key);

  @override
  _MensTopState createState() => _MensTopState();
}

class _MensTopState extends State<MensTop> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController chestController = TextEditingController();
  TextEditingController backController = TextEditingController();
  TextEditingController sleeveController = TextEditingController();
  TextEditingController collarController = TextEditingController();
  TextEditingController cuffController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController aroundArmController = TextEditingController();
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
                    TypewriterAnimatedText(menTopMeasurement,
                        textStyle: TextStyle(
                            color: Colors.indigo, fontSize: fourteenDp)),
                  ],
                ),
              )),

              //first row fow measurement
              ItemRows(
                widgetA: CustomerInputs(
                  valueController: lengthController,
                  imageSource: 'assets/images/length.png',
                  name: length,
                  textColor: CustomColors.c1,
                ),
                widgetB: CustomerInputs(
                  valueController: backController,
                  imageSource: 'assets/images/back.png',
                  name: back,
                  textColor: CustomColors.c4,
                ),
              ),

              //second row for measurement
              ItemRows(
                widgetA: CustomerInputs(
                  valueController: sleeveController,
                  imageSource: 'assets/images/sleeve.png',
                  name: sleeve,
                  textColor: CustomColors.c2,
                ),
                widgetB: CustomerInputs(
                  valueController: collarController,
                  imageSource: 'assets/images/collar.png',
                  name: collar,
                  textColor: CustomColors.c6,
                ),
              ),
              //third row .
              ItemRows(
                widgetA: CustomerInputs(
                  valueController: chestController,
                  imageSource: 'assets/images/chest.png',
                  name: chest,
                  textColor: CustomColors.c7,
                ),
                widgetB: CustomerInputs(
                  valueController: aroundArmController,
                  imageSource: 'assets/images/arm.png',
                  name: aroundArm,
                  textColor: CustomColors.c1,
                ),
              ),
              //fourth row .
              ItemRows(
                  widgetA: CustomerInputs(
                    valueController: cuffController,
                    imageSource: 'assets/images/cuff.png',
                    name: cuff,
                    textColor: CustomColors.c4,
                  ),
                  widgetB: Container()),
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
                          _dressProvider.setMensTopData(
                              nameController.text,
                              "${CustomNameAndNumber.cc}${phoneNumberController.text}",
                              lengthController.text,
                              backController.text,
                              sleeveController.text,
                              collarController.text,
                              chestController.text,
                              aroundArmController.text,
                              cuffController.text,
                              widget.month,
                              int.parse(serviceChargeController.text),
                              int.parse(initialPaymentController.text),
                              dtController.text);

                          HomePage.nameControllerString = nameController.text;

                          _dressProvider.createNewDress(
                              context, DressType.MENS_TOP);

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
