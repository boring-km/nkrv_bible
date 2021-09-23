import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkrv_bible/screen/main_screen.dart';

class LoginScreen extends StatelessWidget {

  const LoginScreen({Key? key}) : super(key: key);

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
                const Text("로그인화면"),
                ElevatedButton(onPressed: () {
                  Get.to(const MainScreen());
                }, child: const Text("메인화면으로 이동")),
              ],
            ),
          ),
        ),
      ),
    );
  }

}