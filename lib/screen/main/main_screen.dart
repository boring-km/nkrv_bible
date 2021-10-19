import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nkrv_bible/auth/firebase.dart';
import 'package:nkrv_bible/screen/main/guest_screen.dart';
import '../login_screen.dart';

// ignore: use_key_in_widget_constructors
class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Logger logger = Logger();

  @override
  Widget build(BuildContext context) {

    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final base = w > h ? w / h * 10 : h / w * 10;

    return Scaffold(
      appBar: buildAppBar(base),
      backgroundColor: Colors.black,
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (!snapshot.hasData) {
            return showLoginScreen();
          } else if (snapshot.data!.displayName == null || snapshot.data!.displayName == "") {
            return buildGuestView(context);
          } else {
            return buildMainView(snapshot.data!.displayName!, context, base);
          }
        },
      ),
    );
  }

  AppBar buildAppBar(double base) {
    return AppBar(
      backgroundColor: Colors.black,
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Text("개역개정 성경",
          style: TextStyle(
            fontSize: base * 2.5,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildMainView(String displayName, BuildContext context, double base) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        buildUserWidget(base, displayName),
        buildFourButtons(w, h, base),
      ],
    );
  }

  Center buildFourButtons(double w, double h, double base) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () => Get.toNamed('/bible/select'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      primary: Colors.white,
                      onSurface: Colors.white70,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 32,
                            left: 32,
                            right: 32,
                            bottom: 8,
                          ),
                          child: Image.asset(
                            'assets/icon/icon_bible.png',
                            width: w / 5,
                            height: h / 8,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Text("성경\n전체 보기",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: base * 1.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () => Get.toNamed('/bible/select'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      primary: Colors.white,
                      onSurface: Colors.white70,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 32,
                            left: 32,
                            right: 32,
                            bottom: 8,
                          ),
                          child: Image.asset(
                            'assets/icon/icon_search.png',
                            width: w / 5,
                            height: h / 8,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Text("빠르게\n검색하기",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: base * 1.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () => Get.toNamed('/bible/select'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      primary: Colors.white,
                      onSurface: Colors.white70,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 32,
                            left: 32,
                            right: 32,
                            bottom: 8,
                          ),
                          child: Image.asset(
                            'assets/icon/icon_bible.png',
                            width: w / 5,
                            height: h / 8,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Text("성경\n전체 보기",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: base * 1.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () => Get.toNamed('/bible/select'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      primary: Colors.white,
                      onSurface: Colors.white70,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 32,
                            left: 32,
                            right: 32,
                            bottom: 8,
                          ),
                          child: Image.asset(
                            'assets/icon/icon_search.png',
                            width: w / 5,
                            height: h / 8,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Text("빠르게\n검색하기",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: base * 1.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                ),
              ),
            ],
          )
        ],
      ),

    );
  }

  Widget buildUserWidget(double base, String displayName) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 16, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            PopupMenuButton(
              color: Colors.white,
              offset: Offset(base * 4, base * 2),
              onSelected: (result) {
                if (result == 1) {
                  Auth.signOut();
                }
              },
              padding: const EdgeInsets.only(right: 0),
              child: Icon(
                CupertinoIcons.profile_circled,
                size: base * 1.5,
                color: Colors.white,
              ),
              itemBuilder: (BuildContext context) {
                var itemList = [
                  PopupMenuItem(
                    value: 1,
                    height: base,
                    padding: const EdgeInsets.all(0),
                    textStyle: TextStyle(color: Colors.black, fontSize: base),
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(
                            Icons.logout,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '로그아웃',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ];
                return itemList;
              },
            ),
            SizedBox(
              width: base / 2,
            ),
            Text(
              displayName,
              style: TextStyle(
                fontSize: base * 1.5,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  LoginScreen showLoginScreen() {
    logger.d("로그인을 해주세요.");
    return LoginScreen();
  }
}