import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taylor_swift/constants/constants.dart';
import 'package:taylor_swift/service/admob_service.dart';
import 'package:taylor_swift/ui/auth/config_page.dart';

class OnboardingScreen extends StatefulWidget {
  static const routeName = '/onboarding';

  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  bool isShowing = false;

  //TODO AD
  // AdmobService admobService = AdmobService();

  @override
  void initState() {
    //TODO AD
    // admobService.createInterstitialAd();
    Timer.periodic(Duration(seconds: 20), (timer) {
      setState(() {
        isShowing = true;
      });
      timer.cancel();
      //  admobService.showInterstitialAd();
    });

    super.initState();
  }

  /*_OnboardingScreenState() {
    Timer.periodic(Duration(seconds: 20), (timer) {
    //  admobService.showInterstitialAd();
      setState(() {
        isShowing = true;
      });
      timer.cancel();
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextLiquidFill(
                        text: welcomeToApp,
                        waveColor: Colors.blueAccent,
                        boxBackgroundColor: Colors.white,
                        textStyle: TextStyle(
                          fontSize: thirtyTwoDp,
                          fontWeight: FontWeight.bold,
                        ),
                        boxHeight: twoHundredDp),
                    SizedBox(
                      height: thirtyDp,
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
                          pause: Duration(seconds: 4),
                          totalRepeatCount: 1,
                          animatedTexts: [
                            TypewriterAnimatedText(
                              fewSteps,
                            ),
                            TypewriterAnimatedText(manageWorks),
                            TypewriterAnimatedText(trackProgress),
                          //  TypewriterAnimatedText(allMeasurementInInches),
                            TypewriterAnimatedText(getNotified),
                          ],
                        ),
                      )),
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

  buildNextButton() {
    return isShowing
        ? Container(
            margin: EdgeInsets.only(bottom: thirtyDp),
            child: GestureDetector(
              onTap: pushToConfigPage,
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
                    continuE,
                    style: TextStyle(fontSize: fourteenDp, color: Colors.white),
                  )),
                ),
              ),
            ),
          )
        : Container();
  }

  pushToConfigPage() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(ConfigurationPage.routeName, (route) => false);
  }
/*  void _tapUp(TapUpDetails details) {
    _controller!.reverse();
  }*/

}
