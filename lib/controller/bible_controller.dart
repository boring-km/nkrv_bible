import 'package:get/get.dart';
import 'package:nkrv_bible/data/bible_item.dart';
import 'package:nkrv_bible/provider/bible_provider.dart';

class BibleController extends GetxController {

  final BibleProvider _provider = Get.put(BibleProvider());

  Future<List<BibleItem>> searchLongLabel(String label, int paragraph, String chapters) {
    return _provider.searchMultiLines(label, paragraph, chapters);
  }
}