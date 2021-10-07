import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroScreen extends StatelessWidget {

  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                width: base,
                height: base,
                child: Center(
                  child: Lottie.asset(
                    'assets/lottie/54020-bible.json',
                  ),
                ),
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
                    isRepeatingAnimation: true,
                    repeatForever: true,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}