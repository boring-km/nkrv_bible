import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'intro_screen.dart';
import 'login_screen.dart';

// ignore: use_key_in_widget_constructors
class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Logger logger = Logger();

  Future <LoginScreen> _signOut() async {
    await FirebaseAuth.instance.signOut();
    return const LoginScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (!snapshot.hasData) {
            logger.d("로그인을 해주세요.");
            return const IntroScreen();
          } else if (snapshot.data!.displayName == null || snapshot.data!.displayName == "") {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("게스트님 환영합니다."),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: CupertinoButton(
                        color: Colors.blue,
                        onPressed: _signOut,
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
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${snapshot.data!.displayName}님 환영합니다."),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: CupertinoButton(
                        color: Colors.blue,
                        onPressed: _signOut,
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
        },
      ),
    );
  }
}