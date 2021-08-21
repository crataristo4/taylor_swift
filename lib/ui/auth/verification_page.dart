import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:taylor_swift/constants/constants.dart';
import 'package:taylor_swift/provider/auth_provider.dart';
import 'package:taylor_swift/ui/widgets/actions.dart';
import 'package:taylor_swift/ui/widgets/progress_dialog.dart';

import '../../main.dart';
import 'config_page.dart';

class VerificationPage extends StatefulWidget {
  static const routeName = '/verification';
  final phoneNumber;

  const VerificationPage({Key? key, this.phoneNumber}) : super(key: key);

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final snackBarKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool isShowing = false;

  //Control the input text field.
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    Timer.periodic(Duration(minutes: 1), (timer) {
      setState(() {
        isShowing = true;
      });
      timer.cancel();
      //  admobService.showInterstitialAd();
    });
    super.initState();
  } //method to verify phone number

  resendCode(BuildContext context) async {
    ShowAction.showAlertDialog(
        confirmNumber,
        "${widget.phoneNumber}",
        context,
        TextButton(
          child: Text(
            cancel,
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: Text(send, style: TextStyle(color: Colors.green)),
          onPressed: () {
            //if yes or ... then push the phone number and user type to verify number
            //NB: The user type will enable you to switch the state between USERS and ARTISAN
            Navigator.pop(context);
            try {
              Provider.of<AuthProvider>(context, listen: false)
                  .verifyPhone(widget.phoneNumber)
                  .then((value) async {
                Dialogs.showLoadingDialog(
                  //show dialog and delay
                    context,
                    loadingKey,
                    sendingCode,
                    Colors.white70);
              }).whenComplete(() {
                Navigator.of(context, rootNavigator: false).pop(true);
                ShowAction().showToast(successful, Colors.green);
              }).catchError((e) {
                String errorMsg = cantAuthenticate;
                if (e.toString().contains(containsBlockedMsg)) {
                  errorMsg = plsTryAgain;
                }
                ShowAction().showErrorDialog(context, errorMsg);
              });
            } catch (e) {
              ShowAction().showErrorDialog(context, e.toString());
            }
          },
        ));
  }

  //verify OTP
  verifyOTP(BuildContext context) {
    try {
      Provider.of<AuthProvider>(context, listen: false)
          .verifyOTP(_controller.text.toString())
          .then((_) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            ConfigurationPage.routeName, (route) => false);
      }).catchError((e) {
        String errorMsg = cantAuthenticate;
        if (e.toString().contains("ERROR_SESSION_EXPIRED")) {
          errorMsg = "Session expired, please resend OTP!";
        } else if (e.toString().contains("ERROR_INVALID_VERIFICATION_CODE")) {
          errorMsg = "You have entered wrong OTP!";
        }
        ShowAction().showErrorDialog(context, errorMsg);
      });
    } catch (e) {
      ShowAction().showErrorDialog(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            isShowing
                ? SizedBox(
                    height: fortyEightDp,
                    child: Container(
                      margin: EdgeInsets.only(right: eightDp, top: eightDp),
                      child: TextButton(
                          style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.pink,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(eightDp),
                                  side: BorderSide(
                                      width: 1, color: Colors.white))),
                          onPressed: () => resendCode(context),
                          child: Text(
                            resend,
                            style: TextStyle(fontSize: fourteenDp),
                          )),
                    ),
                  )
                : Container()
          ],
          elevation: 0,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              margin: EdgeInsets.all(tenDp),
              decoration: BoxDecoration(
                  border: Border.all(width: 0.3, color: Colors.grey),
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(thirtyDp)),
              child: Padding(
                padding: EdgeInsets.all(eightDp),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: sixteenDp,
                ),
              ),
            ),
          ),
          backgroundColor: Colors.white12,
          iconTheme: IconThemeData(color: Colors.black),
          title: DefaultTextStyle(
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: twentyDp, fontFamily: 'Agne', color: Colors.black),
            child: AnimatedTextKit(
              // totalRepeatCount: 1,
              isRepeatingAnimation: true,
              animatedTexts: [WavyAnimatedText(verifyNumber)],
            ),
          )),
      body: Container(
        margin: EdgeInsets.all(twentyFourDp),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: twentyDp,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(eightDp),
                        margin: EdgeInsets.symmetric(horizontal: eightDp),
                        child: Center(
                            child: DefaultTextStyle(
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: twentyDp,
                                  fontFamily: 'Agne',
                                  color: Colors.black),
                              child: AnimatedTextKit(
                                pause: Duration(seconds: 3),
                                totalRepeatCount: 1,
                                animatedTexts: [
                                  TypewriterAnimatedText(
                                    almostDone,
                                  ),
                                  TypewriterAnimatedText(verifyRobot),
                                  TypewriterAnimatedText(enterPIN),
                                ],
                              ),
                            )),
                      ),
                      /*   Text(
                        enterVerificationCode,
                        style: TextStyle(
                            fontSize: sixteenDp,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink),
                      ),
                      Text(widget.phoneNumber,
                          style: TextStyle(
                              fontSize: fourteenDp,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor)),*/
                      /*   SizedBox(height: fortyEightDp),
                      Text(code,
                          style: TextStyle(
                              fontSize: fourteenDp,
                              fontWeight: FontWeight.bold)),*/
                      Center(
                        child: Container(
                          width: 150,
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                                textAlign: TextAlign.center,
                                smartDashesType: SmartDashesType.enabled,
                                smartQuotesType: SmartQuotesType.enabled,
                                autofocus: true,
                                controller: _controller,
                                validator: (value) {
                                  if (value!.length < 6) {
                                    return invalidCode;
                                  }

                                  return null;
                                },
                                maxLength: 6,
                                keyboardType: TextInputType.number,
                                onChanged: (code) {
                                  if (_formKey.currentState!.validate())
                                    // _onFormSubmitted();
                                    verifyOTP(context);
                                },
                                maxLengthEnforcement:
                                MaxLengthEnforcement.enforced,
                                decoration: InputDecoration(
                                  suffix: Icon(
                                    Icons.dialpad_rounded,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  hintText: "X X X X X X",
                                  fillColor: Color(0xFFF5F5F5),
                                  filled: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: tenDp),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Color(0xFFF5F5F5))),
                                  border: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Color(0xFFF5F5F5))),
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //Buttons
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //verify button
                      SizedBox(
                        height: fortyEightDp,
                        child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                primary: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(eightDp))),
                            onPressed: () => _formKey.currentState!
                                .validate() // first check if the code length is six
                                ? verifyOTP(context) // then perform action
                                : ShowAction() // else show error message
                                .showToast(invalidOTP, Colors.red),
                            child: Text(
                              confirmOTP,
                              style: TextStyle(fontSize: fourteenDp),
                            )),
                      ),
                      SizedBox(height: eightDp),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
