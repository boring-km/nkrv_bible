import 'package:get/get.dart';
import 'dart:convert';

import 'package:nkrv_bible/data/bible_book_count.dart';
import 'package:nkrv_bible/data/bible_item.dart';
import 'package:nkrv_bible/data/response_data.dart';

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
    final String? body = response.bodyString;
    if (body == null || body.isEmpty) {
      return "";
    }
    var decodedBody = json.decode(body);
    var responseData = ResponseData<BibleItem>.fromJson(decodedBody);
    return responseData.response.sentence;
  }

  Future<List<BibleItem>> searchMultiLines(String label, int paragraph, String chapters) async {
    final response = await get('$localUrl/searchMul/$label/$paragraph/$chapters');
    final String? body = response.bodyString;
    if (body == null || body.isEmpty) {
      return [];
    }
    var decode = json.decode(body);
    return ResponseData<BibleItemList>.fromJson(decode).response.list;
  }

  Future<List<BibleItem>> searchParagraph(String label, int paragraph) async {
    final response = await get('$localUrl/search/$label/$paragraph');
    final String? body = response.bodyString;
    if (body == null || body.isEmpty) {
      return [];
    }
    return ResponseData<BibleItemList>.fromJson(json.decode(body)).response.list;
  }

  Future<List<BibleItem>> searchLongLabel(String label) async {
    final response = await get('$localUrl/search/$label');
    final String? body = response.bodyString;
    if (body == null || body.isEmpty) {
      return [];
    }
    return ResponseData<BibleItemList>.fromJson(json.decode(body)).response.list;
  }

  Future<List<BibleBookCount>> getBookCountList(String label) async {
    final response = await get('$localUrl/count/$label');
    final String? body = response.bodyString;
    if (body == null || body.isEmpty) {
      return [];
    }
    return ResponseData<BibleBookCountList>.fromJson(json.decode(body)).response.list;
  }

  Future<int> getPreviousTextTotalLength(String label, int chapter) async {
    final response = await get('$localUrl/textLength/$label/$chapter');
    final body = response.bodyString;
    if (body == null || body.isEmpty) {
      return 0;
    }
    final jsonBody = json.decode(body);
    return jsonBody['result']['result'] as int;
  }
}
