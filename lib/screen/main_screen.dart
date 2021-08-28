import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Controller extends GetxController{
  var version = 0.obs;
  set(int ver) {
    version.value = ver;
  }
}

class MainScreen extends StatelessWidget {

  final Controller c = Get.put(Controller());

  MainScreen({Key? key}) : super(key: key) {
    Future.delayed(Duration.zero, () async {
      c.set(await initializeDB());
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              children: [
                const Text("메인화면"),
                ElevatedButton(onPressed: () {
                  Get.toNamed('/bible');
                }, child: const Text("성경 뷰어"),),
                Obx(() => Text('버전: ${c.version}'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<int> initializeDB() async {
    var databasePath = await getDatabasesPath();
    var database = openDatabase(
      join(databasePath, 'test_db.db'),
      onCreate: (db, version) {
        return db.execute(
          "create table dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)",
        );
      },
      version: 1,
    );
    // 데이터베이스 reference를 얻습니다.
    final Database db = await database;
    final version = await db.getVersion();
    return version;
  }

}