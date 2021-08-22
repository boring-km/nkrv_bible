import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              children: [
                Text("메인화면"),
                ElevatedButton(onPressed: () {
                  Navigator.pushNamed(context, '/bible');
                }, child: Text("성경 뷰어"),)
              ],
            ),
          ),
        ),
      ),
    );
  }

}