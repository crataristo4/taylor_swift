import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:taylor_swift/bloc/login_bloc/login_bloc.dart';
import 'package:taylor_swift/constants/constants.dart';
import 'package:taylor_swift/provider/auth_provider.dart';
import 'package:taylor_swift/service/admob_service.dart';
import 'package:taylor_swift/ui/auth/verification_page.dart';
import 'package:taylor_swift/ui/widgets/actions.dart';
import 'package:taylor_swift/ui/widgets/progress_dialog.dart';

import '../../main.dart';

class RegistrationPage extends StatefulWidget {
  static const routeName = '/registration';

  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController _controller = TextEditingController();
  final loginBloc = LoginBloc();
  bool isShowing = false;
  String selectedCountryCode = '+233';

  _RegistrationPageState() {
    Timer.periodic(Duration(seconds: 8), (timer) {
      setState(() {
        isShowing = true;
      });
      timer.cancel();
    });
  }

  //method to verify phone number
  verifyPhone(BuildContext context) async {
    //if connected show dialog for user to proceed
    String phoneNumber = "$selectedCountryCode${_controller.text}";

    ShowAction.showAlertDialog(
      confirmNumber,
      "$sendCodeTo$phoneNumber",
      context,
      ElevatedButton(
        style:
            ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(edit, style: TextStyle(color: Colors.white)),
      ),
      ElevatedButton(
        onPressed: () {
          //if yes or ... then push the phone number and user type to verify number
          //NB: The user type will enable you to switch the state between USERS and ARTISAN
          Navigator.pop(context);
          try {
            Provider.of<AuthProvider>(context, listen: false)
                .verifyPhone(phoneNumber)
                .then((value) async {
              Dialogs.showLoadingDialog(
                  //show dialog and delay
                  context,
                  loadingKey,
                  sendingCode,
                  Colors.white70);
              await Future.delayed(const Duration(seconds: 3));
              Navigator.of(context, rootNavigator: false).pop(true);

              Navigator.of(context).pushNamed(VerificationPage.routeName,
                  arguments: phoneNumber);
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
        child: Text(send, style: TextStyle(color: Colors.white)),
      ),
    );
  }

  //method to select country code when changed
  void _onCountryChange(CountryCode countryCode) {
    selectedCountryCode = countryCode.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
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
                              valuePrivacy,
                            ),
                            TypewriterAnimatedText(thereFore),
                            TypewriterAnimatedText(enterNumberToVerify),
                          ],
                        ),
                      )),
                    ),
                    buildPhoneNumber(),
                    SizedBox(
                      height: twentyDp,
                    ),
                    Container(
                      height: sixtyDp,
                      child: AdWidget(
                        ad: AdmobService.createBannerSmall()..load(),
                        key: UniqueKey(),
                      ),
                    ),
                  ],
                ),
                buildNextButton()
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildPhoneNumber() {
    //CONTAINER FOR TEXT FORM FIELD
    return isShowing
        ? Container(
            margin: EdgeInsets.symmetric(horizontal: thirtySixDp),
            child: StreamBuilder<String>(
                stream: loginBloc.phoneNumberStream,
                builder: (context, snapshot) {
                  return TextFormField(
                      maxLength: 15,
                      autofocus: true,
                      keyboardType: TextInputType.phone,
                      controller: _controller,
                      onChanged: loginBloc.onPhoneNumberChanged,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      decoration: InputDecoration(
                        hintText: '54 xxx xxxx',
                        errorText: snapshot.error == null
                            ? ""
                            : snapshot.error as String,
                        fillColor: Color(0xFFF5F5F5),
                        prefix: CountryCodePicker(
                          onChanged: _onCountryChange,
                          showFlag: true,
                          initialSelection: selectedCountryCode,
                          showOnlyCountryWhenClosed: false,
                        ),
                        suffix: Padding(
                          padding: EdgeInsets.only(right: eightDp),
                          child: Icon(
                            Icons.call,
                            color: Colors.green,
                          ),
                        ),
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 0, horizontal: fourDp),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFF5F5F5))),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFF5F5F5))),
                      ));
                }),
          )
        : Container();
  }

  //login button
  buildNextButton() {
    return isShowing
        ? StreamBuilder<bool>(
            stream: loginBloc.submitPhoneNumber,
            builder: (context, snapshot) {
              return Container(
                margin: EdgeInsets.only(bottom: thirtyDp),
                child: GestureDetector(
                  onTap: snapshot
                          .hasData //if the text form field has some data then proceed to verify number
                      ? () => verifyPhone(context)
                      : null,
                  child: SizedBox(
                    height: fortyEightDp,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(eightDp)),
                      margin: EdgeInsets.symmetric(horizontal: tenDp),
                      child: Center(
                          child: Text(
                        next,
                        style: TextStyle(
                            fontSize: fourteenDp, color: Colors.white),
                      )),
                    ),
                  ),
                ),
              );
            })
        : Container();
  }
}
