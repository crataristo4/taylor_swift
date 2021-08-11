import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:taylor_swift/constants/constants.dart';
import 'package:taylor_swift/constants/theme_data.dart';
import 'package:taylor_swift/ui/widgets/custom_dt_payment.dart';
import 'package:taylor_swift/ui/widgets/custom_inputs.dart';
import 'package:taylor_swift/ui/widgets/custom_name.dart';
import 'package:taylor_swift/ui/widgets/item_rows.dart';

class MensDress extends StatefulWidget {
  const MensDress({Key? key}) : super(key: key);

  @override
  _MensDressState createState() => _MensDressState();
}

class _MensDressState extends State<MensDress> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController chestController = TextEditingController();
  TextEditingController backController = TextEditingController();
  TextEditingController sleeveController = TextEditingController();
  TextEditingController collarController = TextEditingController();
  TextEditingController cuffController = TextEditingController();
  TextEditingController topLengthController = TextEditingController();
  TextEditingController aroundArmController = TextEditingController();
  TextEditingController waistController = TextEditingController();
  TextEditingController thighsController = TextEditingController();
  TextEditingController barController = TextEditingController();
  TextEditingController seatController = TextEditingController();
  TextEditingController kneeController = TextEditingController();
  TextEditingController trouserLengthController = TextEditingController();
  TextEditingController flapController = TextEditingController();

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
                      TypewriterAnimatedText(menDressMeasurement,
                          textStyle: TextStyle(
                              color: Colors.indigo, fontSize: fourteenDp)),
                    ],
                  ),
                ),
              ),

              //first row fow measurement
              ItemRows(
                widgetA: CustomerInputs(
                  valueController: topLengthController,
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
                  widgetB: Container(
                    margin: EdgeInsets.symmetric(
                        vertical: thirtyDp, horizontal: thirtyDp),
                    child: Center(
                        child: Text(
                      "Top",
                      style:
                          TextStyle(fontSize: twentyDp, color: Colors.indigo),
                    )),
                  )),

              //first row fow measurement
              ItemRows(
                widgetA: CustomerInputs(
                  valueController: trouserLengthController,
                  imageSource: 'assets/images/length.png',
                  name: length,
                  textColor: CustomColors.c1,
                ),
                widgetB: CustomerInputs(
                  valueController: waistController,
                  imageSource: 'assets/images/mwst.png',
                  name: waist,
                  textColor: CustomColors.c4,
                ),
              ),

              //second row for measurement
              ItemRows(
                widgetA: CustomerInputs(
                  valueController: thighsController,
                  imageSource: 'assets/images/thigh.png',
                  name: thighs,
                  textColor: CustomColors.c2,
                ),
                widgetB: CustomerInputs(
                  valueController: barController,
                  imageSource: 'assets/images/bar.png',
                  name: bar,
                  textColor: CustomColors.c6,
                ),
              ),
              //third row .
              ItemRows(
                widgetA: CustomerInputs(
                  valueController: seatController,
                  imageSource: 'assets/images/seat.png',
                  name: seat,
                  textColor: CustomColors.c7,
                ),
                widgetB: CustomerInputs(
                  valueController: kneeController,
                  imageSource: 'assets/images/knee.png',
                  name: knee,
                  textColor: CustomColors.c1,
                ),
              ),
              //fourth row .
              ItemRows(
                  widgetA: CustomerInputs(
                    valueController: flapController,
                    imageSource: 'assets/images/flap.png',
                    name: flap,
                    textColor: CustomColors.c4,
                  ),
                  widgetB: Container(
                    margin: EdgeInsets.symmetric(
                        vertical: thirtyDp, horizontal: thirtyDp),
                    child: Center(
                        child: Text(
                      "Trouser",
                      style: TextStyle(fontSize: 20, color: Colors.purple),
                    )),
                  )),
              //fifth row .
              CustomDtPmt(),

              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print('good to goo');
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
