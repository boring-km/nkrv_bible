import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
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
                Text("로딩화면"),
                ElevatedButton(onPressed: () {
                  Navigator.pushNamed(context, '/main');
                }, child: Text("메인화면")),
                ElevatedButton(onPressed: () {
                  Navigator.pushNamed(context, '/login');
                }, child: Text("로그인 화면"))
              ],
            ),
          ),
        ),
      ),
    );
  }

}