import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nkrv_bible/res/custom_colors.dart';
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
    return LoginScreen();
  }

  @override
  Widget build(BuildContext context) {

    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final base = w > h ? w / h * 10 : h / w * 10;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text("개역개정 성경",
            style: TextStyle(
              fontSize: base * 3,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
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

  Widget buildMainView(String displayName, BuildContext context, double base) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PopupMenuButton(
                  color: Colors.white,
                  offset: Offset(base * 6, base * 3),
                  onSelected: (result) {
                    if (result == 1) {
                      _signOut();
                    }
                  },
                  child: Icon(
                    CupertinoIcons.profile_circled,
                    size: base * 2.5,
                    color: Colors.white,
                  ),
                  itemBuilder: (BuildContext context) {
                    var itemList = [
                      PopupMenuItem(
                        value: 1,
                        height: base * 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 2.0),
                              child: Icon(
                                Icons.logout,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              '로그아웃',
                              style: TextStyle(color: Colors.black, fontSize: base),
                            )
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
                    fontSize: base * 2,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        Center(
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
                            Image.asset(
                              'assets/icon/icon_bible.png',
                              width: w / 4,
                              height: h / 4,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text("성경 전체 보기",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: base * 2,
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
                            Image.asset(
                              'assets/icon/icon_bible.png',
                              width: w / 4,
                              height: h / 4,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text("성경 전체 보기",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: base * 2,
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
                            Image.asset(
                              'assets/icon/icon_bible.png',
                              width: w / 4,
                              height: h / 4,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text("성경 전체 보기",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: base * 2,
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
                            Image.asset(
                              'assets/icon/icon_bible.png',
                              width: w / 4,
                              height: h / 4,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text("성경 전체 보기",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: base * 2,
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
        ),
      ],
    );
  }

  LoginScreen showLoginScreen() {
    logger.d("로그인을 해주세요.");
    return LoginScreen();
  }

  Center buildGuestView(BuildContext context) {
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
              width: MediaQuery.of(context).size.width,
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
}