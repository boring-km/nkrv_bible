import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkrv_bible/auth/firebase.dart';
import 'package:nkrv_bible/provider/main_provider.dart';
import '../book_select_screen.dart';
import 'guest_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget? bodyWidget;
  Provider? _provider;
  UserStatus userStatus = UserStatus.NONE;
  bool isInitialized = false;
  String name = "";

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      _provider = Provider();
      await _provider!.getUser();
      userStatus = _provider!.userStatus;
      name = _provider!.name;
      setState(() {
        isInitialized = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final base = w > h ? w / h * 10 : h / w * 10;

    if (!isInitialized) {
      return buildLoadingView();
    }

    return Scaffold(
      appBar: buildAppBar(base),
      backgroundColor: Colors.black,
      body: showView(),
    );
  }

  buildAppBar(double base) {
    if (!isLogged()) {
      return null;
    }
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

  Widget showView() {
    if (userStatus == UserStatus.GUEST) {
      return buildGuestView(Get.width);
    } else if (userStatus == UserStatus.USER) {
      return buildMainView(name);
    } else {
      return Container();
    }
  }

  Widget buildMainView(String displayName) {
    var w = Get.width;
    var h = Get.height;
    final base = w > h ? w / h * 10 : h / w * 10;

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
                    onPressed: () => Get.to(const BookSelectScreen(), transition: Transition.fade),
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
                    onPressed: () => Get.to(const BookSelectScreen(), transition: Transition.fade),
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
                    onPressed: () => Get.to(const BookSelectScreen(), transition: Transition.fade),
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
                    onPressed: () => Get.to(const BookSelectScreen(), transition: Transition.fade),
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
                  Get.offAll(const MainScreen());
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

  bool isLogged() {
    return userStatus != UserStatus.NONE;
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