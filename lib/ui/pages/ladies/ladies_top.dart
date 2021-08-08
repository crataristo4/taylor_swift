import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:taylor_swift/constants/constants.dart';
import 'package:taylor_swift/constants/theme_data.dart';
import 'package:taylor_swift/ui/widgets/custom_inputs.dart';
import 'package:taylor_swift/ui/widgets/custom_name.dart';
import 'package:taylor_swift/ui/widgets/item_rows.dart';

class LadiesTop extends StatefulWidget {
  const LadiesTop({Key? key}) : super(key: key);

  @override
  _LadiesTopState createState() => _LadiesTopState();
}

class _LadiesTopState extends State<LadiesTop> {
  TextEditingController nameController = TextEditingController();
  TextEditingController waistController = TextEditingController();
  TextEditingController bustController = TextEditingController();
  TextEditingController hipController = TextEditingController();
  TextEditingController shoulderController = TextEditingController();
  TextEditingController nipToNipController = TextEditingController();
  TextEditingController shoToNipController = TextEditingController();
  TextEditingController shoToWaistController = TextEditingController();
  TextEditingController topLengthController = TextEditingController();
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
                    TypewriterAnimatedText(ladiesTopMeasurement,
                        textStyle: TextStyle(color: Colors.indigo)),
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
                  valueController: bustController,
                  imageSource: 'assets/images/bust.png',
                  name: bust,
                  textColor: CustomColors.c4,
                ),
              ),

              //second row for measurement
              ItemRows(
                widgetA: CustomerInputs(
                  valueController: hipController,
                  imageSource: 'assets/images/hip.png',
                  name: hip,
                  textColor: CustomColors.c2,
                ),
                widgetB: CustomerInputs(
                  valueController: shoulderController,
                  imageSource: 'assets/images/shoda.png',
                  name: shoulder,
                  textColor: CustomColors.c6,
                ),
              ),
              //third row .
              ItemRows(
                widgetA: CustomerInputs(
                  valueController: shoToWaistController,
                  imageSource: 'assets/images/shoToWaist.png',
                  name: nippleToNipple,
                  textColor: CustomColors.c7,
                ),
                widgetB: CustomerInputs(
                  valueController: nipToNipController,
                  imageSource: 'assets/images/nipple.png',
                  name: shoulderToNipple,
                  textColor: CustomColors.c1,
                ),
              ),
              //fourth row .
              ItemRows(
                widgetA: CustomerInputs(
                  valueController: sleeveLengthController,
                  imageSource: 'assets/images/sleeve.png',
                  name: shoulderToWaist,
                  textColor: CustomColors.c4,
                ),
                widgetB: CustomerInputs(
                  valueController: aroundArmController,
                  imageSource: 'assets/images/arm.png',
                  name: knee,
                  textColor: CustomColors.c6,
                ),
              ),
              //fifth row .
              ItemRows(
                  widgetA: CustomerInputs(
                    valueController: topLengthController,
                    imageSource: 'assets/images/ltop.png',
                    name: topLength,
                    textColor: CustomColors.c1,
                  ),
                  widgetB: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print('good to goo');
                        }
                      },
                      label: Text(save),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
