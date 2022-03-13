import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:taylor_swift/bloc/login_bloc/login_bloc.dart';
import 'package:taylor_swift/constants/constants.dart';
import 'package:taylor_swift/provider/auth_provider.dart';
import 'package:taylor_swift/service/admob_service.dart';
import 'package:taylor_swift/ui/auth/login_page.dart';
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
  TextEditingController _passController = TextEditingController();
  TextEditingController _confirmPassController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();
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

          debugPrint('test');
           try {
             FirebaseFirestore.instance
                 .collection("users")
                 .get()
                 .then((value) {
               debugPrint('test   value  ${value.size}');
               bool exist = false;
               for(var item in value.docs){
                 debugPrint('test   item  ${item.get('phone')} == $phoneNumber  ${item.get('phone') == phoneNumber}');

                 if(item.get('phone') == phoneNumber){
                   ShowAction().showErrorDialog(context, 'Phone Number is already exist!');
                   exist = true;
                   break;
                 }
                 if(item.get('email') == _emailController.text){
                   ShowAction().showErrorDialog(context, 'Email is already exist!');
                   exist = true;
                   break;
                 }
               }
               if(!exist){
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
                         arguments: [phoneNumber,_passController.text,_emailController.text]);
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
               }


             }).catchError((error){
               debugPrint('test catchError $error');
               ShowAction().showErrorDialog(context, error);

             });
           } on Exception catch (error) {
             // TODO
             debugPrint('test catchError ${error.toString()}');
             ShowAction().showErrorDialog(context, error.toString());
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
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: formKey,
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
                      buildEmail(),
                      buildPassword(),
                      buildConfirmPassword(),
                      SizedBox(
                        height: twentyDp,
                      ),
                      //TODO AD
                      // Container(
                      //   height: sixtyDp,
                      //   child: AdWidget(
                      //     ad: AdmobService.createBannerSmall()..load(),
                      //     key: UniqueKey(),
                      //   ),
                      // ),
                    ],
                  ),
                  buildNextButton()
                ],
              ),
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
                        prefixIcon: CountryCodePicker(
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

  Widget buildPassword() {
    //CONTAINER FOR TEXT FORM FIELD
    return isShowing
        ? Container(
            margin: EdgeInsets.symmetric(horizontal: thirtySixDp),
            child: StreamBuilder<String>(
                stream: loginBloc.passwordStream,
                builder: (context, snapshot) {
                  return TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: _passController,
                      onChanged: loginBloc.onPasswordChanged,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        errorText: snapshot.error == null
                            ? ""
                            : snapshot.error as String,
                        fillColor: Color(0xFFF5F5F5),
                        prefixIcon: Icon(Icons.password),
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

  Widget buildConfirmPassword() {
    //CONTAINER FOR TEXT FORM FIELD
    return isShowing
        ? Container(
            margin: EdgeInsets.symmetric(horizontal: thirtySixDp),
            child: TextFormField(
                validator: (value) {
                  if(value != _passController.text)
                    return "Password doesn't match";
                  return null;
                },
                keyboardType: TextInputType.visiblePassword,
                controller: _confirmPassController,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  fillColor: Color(0xFFF5F5F5),
                  prefixIcon: Icon(Icons.check_rounded),
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 0, horizontal: fourDp),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFF5F5F5))),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFF5F5F5))),
                ),

            ),
          )
        : Container();
  }

  Widget buildEmail() {
    //CONTAINER FOR TEXT FORM FIELD
    return isShowing
        ? Container(
            margin: EdgeInsets.symmetric(horizontal: thirtySixDp,vertical: 10),
            child: TextFormField(
                validator: (value) {
                  if(_emailController.text.isEmpty)
                    return "Email is required";
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                decoration: InputDecoration(
                  hintText: 'Email',
                  fillColor: Color(0xFFF5F5F5),
                  prefixIcon: Icon(Icons.email),
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 0, horizontal: fourDp),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFF5F5F5))),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFF5F5F5))),
                ),

            ),
          )
        : Container();
  }

  //login button
  buildNextButton() {
    return isShowing
        ? StreamBuilder<bool>(
            stream: loginBloc.submitPhoneNumber,
            builder: (context, snapshot) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    child: GestureDetector(
                      onTap: snapshot
                              .hasData //if the text form field has some data then proceed to verify number
                          ? () {
                        if (formKey.currentState!.validate())
                          verifyPhone(context);
                      }
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
                  ),
                  TextButton(onPressed: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => LoginPage()));
                  }, child: Text('Already have account?'))
                ],
              );
            })
        : Container();
  }
}
