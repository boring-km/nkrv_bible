import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nkrv_bible/screen/login_screen.dart';


class IntroScreen extends StatelessWidget {

  IntroScreen({Key? key}) : super(key: key) {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAll(const LoginScreen(), transition: Transition.fade);
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    double base = w > h ? h * (3/4) : w * (3/4) ;

    final bottomTextShadow = [
      const Shadow(
        color: Colors.white,
        offset: Offset(1, 1),
        blurRadius: 10,
      ),
      const Shadow(
        color: Colors.white,
        offset: Offset(-1, -1),
        blurRadius: 10,
      )
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                width: base,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: base / 10),
                child: DefaultTextStyle(
                  style: TextStyle(
                    fontSize: base/4,
                    color: Colors.white,
                    shadows: bottomTextShadow,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      FadeAnimatedText('개역개정 성경', duration: const Duration(seconds: 3),),
                    ],
                    isRepeatingAnimation: false,
                  ),
                ),
              ),
            ),
            Center(
              child: Lottie.asset(
                'assets/lottie/54020-bible.json',
                width: base,
                height: base,
              ),
            ),
          ],
        ),
      ),
    );
  }

}