import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nkrv_bible/screen/main_screen.dart';

// ignore: use_key_in_widget_constructors
class App extends StatelessWidget {
  final Logger logger = Logger();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Firebase load fail."),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          logger.d("Firebase load.");
          return MainScreen();
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
