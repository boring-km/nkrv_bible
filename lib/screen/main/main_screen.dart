import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkrv_bible/auth/firebase.dart';
import 'package:nkrv_bible/controller/main_controller.dart';
import 'package:nkrv_bible/screen/main/guest_screen.dart';
import 'package:nkrv_bible/utils/screen_util.dart';
import '../book_select_screen.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setLightStatusBarIcon();

    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final base = w > h ? w / h * 10 : h / w * 10;

    return Scaffold(
      appBar: buildAppBar(base),
      backgroundColor: Colors.white,
      body: buildMainView(controller.name),
    );
  }

  buildAppBar(double base) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Text(
          "개역개정 성경",
          style: TextStyle(
            fontSize: base * 2.5,
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
        ),
      ),
    );
  }

  Widget buildMainView(String displayName) {
    var w = Get.width;
    var h = Get.height;
    final base = w > h ? w / h * 10 : h / w * 10;

    if (controller.isGuest) {
      return buildGuestView(w);
    }

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildUserWidget(base, displayName),
        Expanded(child: buildButtons(w, h, base)),
      ],
    );
  }

  Center buildButtons(double w, double h, double base) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            constraints: const BoxConstraints(maxHeight: 300),
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () => Get.to(const BookSelectScreen(),
                    transition: Transition.fade),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  backgroundColor: Colors.white,
                  disabledForegroundColor: Colors.white70.withOpacity(0.38),
                  disabledBackgroundColor: Colors.white70.withOpacity(0.12),
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
                      child: Text(
                        "성경\n전체 보기",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: base * 1.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )),
          ),
          Container(
            constraints: const BoxConstraints(maxHeight: 300),
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () => Get.to(const BookSelectScreen(),
                    transition: Transition.fade),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  backgroundColor: Colors.white,
                  disabledForegroundColor: Colors.white70.withOpacity(0.38),
                  disabledBackgroundColor: Colors.white70.withOpacity(0.12),
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
                      child: Text(
                        "빠르게\n검색하기",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: base * 1.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )),
          ),
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
              color: Colors.black,
              offset: Offset(base * 4, base * 2),
              onSelected: (result) {
                if (result == 1) {
                  Auth.signOut();
                  Get.offAllNamed('login');
                }
              },
              padding: const EdgeInsets.only(right: 0),
              child: Icon(
                CupertinoIcons.profile_circled,
                size: base * 1.5,
                color: Colors.black,
              ),
              itemBuilder: (BuildContext context) {
                var itemList = [
                  PopupMenuItem(
                    value: 1,
                    height: base,
                    padding: const EdgeInsets.all(0),
                    textStyle: TextStyle(color: Colors.white, fontSize: base),
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(
                            Icons.logout,
                            color: Colors.white,
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
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Scaffold buildLoadingView() {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: 40,
          height: 40,
          child: CircularProgressIndicator(
            color: Colors.redAccent,
          ),
        ),
      ),
    );
  }
}
