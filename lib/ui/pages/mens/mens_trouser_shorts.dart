import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:taylor_swift/constants/constants.dart';
import 'package:taylor_swift/constants/theme_data.dart';
import 'package:taylor_swift/ui/widgets/custom_dt_payment.dart';
import 'package:taylor_swift/ui/widgets/custom_inputs.dart';
import 'package:taylor_swift/ui/widgets/custom_name.dart';
import 'package:taylor_swift/ui/widgets/item_rows.dart';

class MensTrouserOrShorts extends StatefulWidget {
  const MensTrouserOrShorts({Key? key}) : super(key: key);

  @override
  _MensTrouserOrShortsState createState() => _MensTrouserOrShortsState();
}

class _MensTrouserOrShortsState extends State<MensTrouserOrShorts> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController waistController = TextEditingController();
  TextEditingController thighsController = TextEditingController();
  TextEditingController barController = TextEditingController();
  TextEditingController seatController = TextEditingController();
  TextEditingController kneeController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
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
                    TypewriterAnimatedText(mTrouserOrShorts,
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
                  valueController: waistController,
                  imageSource: 'assets/images/back.png',
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
                  widgetB: Container()),
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
