import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkrv_bible/data/bible_item.dart';
import 'package:nkrv_bible/data/result.dart';
import 'package:nkrv_bible/provider/bible_provider.dart';
import 'package:nkrv_bible/screen/bible_ui_event.dart';

class BibleController extends GetxController {

  final BibleProvider _provider = Get.put(BibleProvider());

  List<BibleItem> bibleList = [];

  final eventController = StreamController<BibleUiEvent>();
  Stream<BibleUiEvent> get eventStream => eventController.stream;

  @override
  void onInit() {
    searchLongLabel('창세기', 1, '1-12');
    check();
    super.onInit();
  }

  check() {
    Future.microtask(() => eventStream.listen((event) {
      event.when(showDialog: (message) {
        showDialog(context: Get.context!, builder: (context) {
          return AlertDialog(
            title: SizedBox(
              width: 300,
              height: 300,
              child: Center(
                child: Text(message),
              ),
            ),
          );
        });
      });
    }));
  }

  searchLongLabel(String label, int paragraph, String chapters) async {
    Result<List<BibleItem>> result = await _provider.searchMultiLines(label, paragraph, chapters);

    result.when(
      success: (list) {
        bibleList = list;
        update();
      },
      error: (message) {
        eventController.add(BibleUiEvent.showDialog(message));
      },
    );
  }
}