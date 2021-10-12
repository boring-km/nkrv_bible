import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nkrv_bible/screen/main_screen.dart';

// ignore: use_key_in_widget_constructors
class App extends StatelessWidget {
  final Logger logger = Logger();

  @override
  Widget build(BuildContext context) {
    check();
    return const Scaffold(
      body: SizedBox(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(
          color: Colors.redAccent,
        ),
      ),
    );
  }

  void check() async {
    try {
      await Firebase.initializeApp();
    } on Exception {
      logger.printError(info: "firebase 초기화 에러");
    }
    Get.offAll(MainScreen(), transition: Transition.fadeIn);
  }
}
