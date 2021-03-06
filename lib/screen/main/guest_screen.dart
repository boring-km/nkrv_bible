import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkrv_bible/auth/firebase.dart';

Center buildGuestView(double width) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("게스트님 환영합니다."),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: width,
            child: CupertinoButton(
              color: Colors.blue,
              onPressed: () {
                Get.toNamed('/bible/select');
              },
              child: const Text(
                '성경',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: width,
            child: CupertinoButton(
              color: Colors.blue,
              onPressed: () {
                Auth.signOut();
                Get.offAllNamed('login');
              },
              child: const Text(
                '로그아웃',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}