import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {

  const MainScreen({Key? key}) : super(key: key);

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
                const Text("메인화면"),
                ElevatedButton(onPressed: () {
                  Get.toNamed('/bible/select');
                }, child: const Text("성경 보기"),),
              ],
            ),
          ),
        ),
      ),
    );
  }

}