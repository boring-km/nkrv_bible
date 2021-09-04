import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nkrv_bible/data/bible_book_count.dart';
import 'package:nkrv_bible/data/bible_item.dart';

class BibleAPI {
  static Future<String> searchOne(String longLabel, int paragraph, int chapter) async {
    final uri = Uri.parse('http://ec2-3-38-12-80.ap-northeast-2.compute.amazonaws.com/searchOne/$longLabel/$paragraph/$chapter');
    final response = await http.get(uri);
    final body = response.body;
    final jsonBody = jsonDecode(body);
    var item = jsonBody['text'][0];
    return BibleItem(item['long_label'], item['chapter'], item['paragraph'], item['sentence']).sentence;
  }

  static Future<List<BibleItem>> searchMultiLines(String longLabel, int paragraph, String chapters) async {
    final uri = Uri.parse('http://ec2-3-38-12-80.ap-northeast-2.compute.amazonaws.com/searchMul/$longLabel/$paragraph/$chapters');
    final response = await http.get(uri);
    final body = response.body;
    final jsonBody = jsonDecode(body);
    final itemList = jsonBody['text'] as List<dynamic>;
    List<BibleItem> data = [];
    for (var item in itemList) {
      data.add(BibleItem(item['long_label'], item['chapter'], item['paragraph'], item['sentence']));
    }
    return data;
  }

  static Future<List<BibleItem>> searchParagraph(String longLabel, int paragraph) async {
    final uri = Uri.parse('http://ec2-3-38-12-80.ap-northeast-2.compute.amazonaws.com/search/$longLabel/$paragraph');
    final response = await http.get(uri);
    final body = response.body;
    final jsonBody = jsonDecode(body);
    final itemList = jsonBody['text'] as List<dynamic>;
    List<BibleItem> data = [];
    for (var item in itemList) {
      data.add(BibleItem(item['long_label'], item['chapter'], item['paragraph'], item['sentence']));
    }
    return data;
  }

  static Future<List<BibleItem>> searchLongLabel(String longLabel) async {
    final uri = Uri.parse('http://ec2-3-38-12-80.ap-northeast-2.compute.amazonaws.com/search/$longLabel');
    final response = await http.get(uri);
    final body = response.body;
    final jsonBody = jsonDecode(body);
    final itemList = jsonBody['text'] as List<dynamic>;
    List<BibleItem> data = [];
    for (var item in itemList) {
      data.add(BibleItem(item['long_label'], item['chapter'], item['paragraph'], item['sentence']));
    }
    return data;
  }

  static Future<List<BibleBookCount>> getBookCountList(String longLabel) async {
    final uri = Uri.parse('http://ec2-3-38-12-80.ap-northeast-2.compute.amazonaws.com/count/$longLabel');
    final response = await http.get(uri);
    final body = response.body;
    final jsonBody = jsonDecode(body);
    final itemList = jsonBody['result'] as List<dynamic>;
    List<BibleBookCount> data = [];
    for (var item in itemList) {
      data.add(BibleBookCount(longLabel, item['chapter'], item['count']));
    }
    return data;
  }
}