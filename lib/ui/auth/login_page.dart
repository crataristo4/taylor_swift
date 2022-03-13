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
import 'package:taylor_swift/service/auth.dart';
import 'package:taylor_swift/ui/auth/registration_page.dart';
import 'package:taylor_swift/ui/auth/verification_page.dart';
import 'package:taylor_swift/ui/widgets/actions.dart';
import 'package:taylor_swift/ui/widgets/progress_dialog.dart';

import '../../main.dart';

class LoginPage extends StatefulWidget {
  // static const routeName = '/login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _controller = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  final loginBloc = LoginBloc();
  bool isShowing = true;
  String selectedCountryCode = '+233';

  // _LoginPageState() {
  //   Timer.periodic(Duration(seconds: 8), (timer) {
  //     setState(() {
  //       isShowing = true;
  //     });
  //     timer.cancel();
  //   });
  // }


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

                              TypewriterAnimatedText(enteremailToLog),
                            ],
                          ),
                        )),
                      ),
                      buildEmail(),
                      buildPassword(),
                      SizedBox(
                        height: twentyDp,
                      ),
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
                      validator: (value) {
                        if (value.toString().length < 9) {
                          return invalidPhone;
                        }
                        if (value.toString().startsWith('0')) {
                          return nonZero;
                        }
                        return null;

                      },
                      keyboardType: TextInputType.phone,
                      controller: _controller,
                      onChanged: loginBloc.onPhoneNumberChanged,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      decoration: InputDecoration(
                        hintText: '54 xxx xxxx',
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

  Widget buildPassword() {
    //CONTAINER FOR TEXT FORM FIELD
    return isShowing
        ? Container(
            margin: EdgeInsets.symmetric(horizontal: thirtySixDp),
            child: TextFormField(

              validator: (value) {
                if(value!.isEmpty)
                  return invalidPass;
                return null;
              },
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                controller: _passController,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                decoration: InputDecoration(
                  hintText: 'Password',
                  fillColor: Color(0xFFF5F5F5),
                  prefixIcon: Icon(Icons.password),
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 0, horizontal: fourDp),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFF5F5F5))),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFF5F5F5))),
                )),
          )
        : Container();
  }

  //login button
  buildNextButton() {
    return isShowing
        ? Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          child: GestureDetector(
            onTap: () {
              if (formKey.currentState!.validate()) {
                Auth().login({
                  // "phone": '$selectedCountryCode${_controller.text}',
                  "email": _emailController.text,
                  "password": _passController.text,
                }, context);
              }
            },
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
                      "Log in",
                      style: TextStyle(
                          fontSize: fourteenDp, color: Colors.white),
                    )),
              ),
            ),
          ),
        ),
        TextButton(onPressed: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => RegistrationPage()));
        }, child: Text("Don't have account?"))
      ],
    )
        : Container();
  }
}
