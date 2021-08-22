import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BibleScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BibleScreenState();
}

class _BibleScreenState extends State<BibleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child: Text("성경 뷰어", style: TextStyle(fontSize: 24),),
          ),
        ),
      ),
    );
  }

}