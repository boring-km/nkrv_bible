import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nkrv_bible/data/bible_book_count.dart';
import 'package:nkrv_bible/data/bible_item.dart';

class BibleAPI {

  static const baseUrl = 'http://192.168.13.72:3000';

  static Future<String> searchOne(String label, int paragraph, int chapter) async {
    final uri = Uri.parse('$baseUrl/searchOne/$label/$paragraph/$chapter');
    final response = await http.get(uri);
    final body = response.body;
    final jsonBody = jsonDecode(body);
    var item = jsonBody['text'][0];
    return BibleItem(item['label'], item['chapter'], item['paragraph'], item['sentence']).sentence;
  }

  static Future<List<BibleItem>> searchMultiLines(String label, int paragraph, String chapters) async {
    final uri = Uri.parse('$baseUrl/searchMul/$label/$paragraph/$chapters');
    final response = await http.get(uri);
    final body = response.body;
    final jsonBody = jsonDecode(body);
    final itemList = jsonBody['text'] as List<dynamic>;
    List<BibleItem> data = [];
    for (var item in itemList) {
      data.add(BibleItem(item['label'], item['chapter'], item['paragraph'], item['sentence']));
    }
    return data;
  }

  static Future<List<BibleItem>> searchParagraph(String label, int paragraph) async {
    final uri = Uri.parse('$baseUrl/search/$label/$paragraph');
    final response = await http.get(uri);
    final body = response.body;
    final jsonBody = jsonDecode(body);
    final itemList = jsonBody['text'] as List<dynamic>;
    List<BibleItem> data = [];
    for (var item in itemList) {
      data.add(BibleItem(item['label'], item['chapter'], item['paragraph'], item['sentence']));
    }
    return data;
  }

  static Future<List<BibleItem>> searchLongLabel(String label) async {
    final uri = Uri.parse('$baseUrl/search/$label');
    final response = await http.get(uri);
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

  static Future<List<BibleBookCount>> getBookCountList(String label) async {
    final uri = Uri.parse('$baseUrl/count/$label');
    final response = await http.get(uri);
    final body = response.body;
    final jsonBody = jsonDecode(body);
    final itemList = jsonBody['result'] as List<dynamic>;
    List<BibleBookCount> data = [];
    for (var item in itemList) {
      data.add(BibleBookCount(label, item['chapter'], item['count']));
    }
    return data;
  }

  static Future<int> getPreviousTextTotalLength(String label, int chapter) async {
    final uri = Uri.parse('$baseUrl/textLength/$label/$chapter');
    final response = await http.get(uri);
    final body = response.body;
    final jsonBody = jsonDecode(body);
    return jsonBody['result']['result'] as int;
  }
}