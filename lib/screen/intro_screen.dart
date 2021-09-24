import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroScreen extends StatelessWidget {

  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("로딩화면"),
                // ElevatedButton(onPressed: () {
                //   Get.toNamed('/main');
                // }, child: const Text("메인화면")),
                ElevatedButton(onPressed: () {
                  Get.toNamed('/login');
                }, child: const Text("로그인 화면"))
              ],
            ),
          ),
        ),
      ),
    );
  }

}