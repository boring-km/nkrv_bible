import 'package:get/get.dart';
import 'dart:convert';

import 'package:nkrv_bible/data/bible_book_count.dart';
import 'package:nkrv_bible/data/bible_item.dart';

class BibleProvider extends GetConnect {

  final localUrl = 'http://192.168.35.2:3000';

  void withToken(String token) {
    httpClient.addAuthenticator<Object?>((request) async {
      request.headers['x-access-token'] = token;
      return request;
    });
  }

  Future<String> searchOne(String label, int paragraph, int chapter) async {

    final response = await get('$localUrl/searchOne/$label/$paragraph/$chapter');
    final body = response.body;
    final jsonBody = jsonDecode(body);
    var item = jsonBody['text'][0];
    
    return BibleItem(item['label'], item['chapter'], item['paragraph'], item['sentence']).sentence;
  }

  Future<List<BibleItem>> searchMultiLines(String label, int paragraph, String chapters) async {
    final response = await get('$localUrl/searchMul/$label/$paragraph/$chapters');
    final body = response.body;
    final jsonBody = jsonDecode(body);
    final itemList = jsonBody['text'] as List<dynamic>;
    List<BibleItem> data = [];
    for (var item in itemList) {
      data.add(BibleItem(item['label'], item['chapter'], item['paragraph'], item['sentence']));
    }
    return data;
  }

  Future<List<BibleItem>> searchParagraph(String label, int paragraph) async {
    final response = await get('$localUrl/search/$label/$paragraph');
    final body = response.body;
    final jsonBody = jsonDecode(body);
    final itemList = jsonBody['text'] as List<dynamic>;
    List<BibleItem> data = [];
    for (var item in itemList) {
      data.add(BibleItem(item['label'], item['chapter'], item['paragraph'], item['sentence']));
    }
    return data;
  }

  Future<List<BibleItem>> searchLongLabel(String label) async {
    final response = await get('$localUrl/search/$label');
    final body = response.body;
    final jsonBody = jsonDecode(body);
    final itemList = jsonBody['text'] as List<dynamic>;
    List<BibleItem> data = [];
    for (var item in itemList) {
      var bibleItem = BibleItem(item['label'], item['chapter'], item['paragraph'], item['sentence']);
      data.add(bibleItem);
    }
    return data;
  }

  Future<List<BibleBookCount>> getBookCountList(String label) async {
    final response = await get('$localUrl/count/$label');
    final body = response.body;
    final jsonBody = jsonDecode(body);
    final itemList = jsonBody['result'] as List<dynamic>;
    List<BibleBookCount> data = [];
    for (var item in itemList) {
      data.add(BibleBookCount(label, item['chapter'], item['count']));
    }
    return data;
  }

  Future<int> getPreviousTextTotalLength(String label, int chapter) async {
    final response = await get('$localUrl/textLength/$label/$chapter');
    final body = response.body;
    final jsonBody = jsonDecode(body);
    return jsonBody['result']['result'] as int;
  }
}
