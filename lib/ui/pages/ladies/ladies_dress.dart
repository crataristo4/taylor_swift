import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:taylor_swift/constants/constants.dart';
import 'package:taylor_swift/constants/theme_data.dart';
import 'package:taylor_swift/ui/widgets/custom_inputs.dart';
import 'package:taylor_swift/ui/widgets/custom_name.dart';

class LadiesDress extends StatefulWidget {
  const LadiesDress({Key? key}) : super(key: key);

  @override
  _LadiesDressState createState() => _LadiesDressState();
}

class _LadiesDressState extends State<LadiesDress> {
  TextEditingController nameController = TextEditingController();
  TextEditingController waistController = TextEditingController();
  TextEditingController bustController = TextEditingController();
  TextEditingController hipController = TextEditingController();
  TextEditingController shoulderController = TextEditingController();
  TextEditingController nipToNipController = TextEditingController();
  TextEditingController shoToNipController = TextEditingController();
  TextEditingController shoToWaistController = TextEditingController();
  TextEditingController kneeController = TextEditingController();
  TextEditingController dressLengthController = TextEditingController();
  TextEditingController sleeveLengthController = TextEditingController();
  TextEditingController aroundArmController = TextEditingController();

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
              CustomerName(
                nameController: nameController,
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
                    TypewriterAnimatedText(cstMeasurement,
                        textStyle: TextStyle(color: Colors.indigo)),
                  ],
                ),
              )),

              //first row fow measurement
              itemRows(
                CustomerInputs(
                  valueController: waistController,
                  imageSource: 'assets/images/waist.png',
                  name: waist,
                  textColor: CustomColors.c1,
                ),
                CustomerInputs(
                  valueController: bustController,
                  imageSource: 'assets/images/bust.png',
                  name: bust,
                  textColor: CustomColors.c4,
                ),
              ),

              //second row for measurement
              itemRows(
                CustomerInputs(
                  valueController: hipController,
                  imageSource: 'assets/images/hip.png',
                  name: hip,
                  textColor: CustomColors.c2,
                ),
                CustomerInputs(
                  valueController: shoulderController,
                  imageSource: 'assets/images/shoda.png',
                  name: shoulder,
                  textColor: CustomColors.c6,
                ),
              ),
              //third row .
              itemRows(
                CustomerInputs(
                  valueController: nipToNipController,
                  imageSource: 'assets/images/nipple.png',
                  name: nippleToNipple,
                  textColor: CustomColors.c7,
                ),
                CustomerInputs(
                  valueController: shoToNipController,
                  imageSource: 'assets/images/shoToNip.png',
                  name: shoulderToNipple,
                  textColor: CustomColors.c1,
                ),
              ),
              //fourth row .
              itemRows(
                CustomerInputs(
                  valueController: shoToWaistController,
                  imageSource: 'assets/images/shoToWaist.png',
                  name: shoulderToWaist,
                  textColor: CustomColors.c4,
                ),
                CustomerInputs(
                  valueController: kneeController,
                  imageSource: 'assets/images/knee.png',
                  name: knee,
                  textColor: CustomColors.c6,
                ),
              ),
              //fifth row .
              itemRows(
                CustomerInputs(
                  valueController: dressLengthController,
                  imageSource: 'assets/images/dress.png',
                  name: dressLength,
                  textColor: CustomColors.c1,
                ),
                CustomerInputs(
                  valueController: sleeveLengthController,
                  imageSource: 'assets/images/sleeve.png',
                  name: sleeveLength,
                  textColor: CustomColors.c4,
                ),
              ),

              itemRows(
                  CustomerInputs(
                    valueController: aroundArmController,
                    imageSource: 'assets/images/arm.png',
                    name: aroundArm,
                    textColor: CustomColors.c6,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print('good to goo');
                        }
                      },
                      label: Text(save),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Row itemRows(Widget widgetA, Widget widgetB) {
    return Row(
      //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [widgetA, widgetB],
    );
  }
}
