import 'dart:convert';

import 'package:http/http.dart' as http;

class BibleAPI {
  static Future<String> searchOne(String longLabel, int paragraph, int chapter) async {
    final uri = Uri.parse('http://ec2-3-38-12-80.ap-northeast-2.compute.amazonaws.com/searchOne/$longLabel/$paragraph/$chapter');
    final response = await http.get(uri);
    final body = response.body;
    final jsonBody = jsonDecode(body);
    return jsonBody['text'][0]['sentence'] as String;
  }

  static Future<List> searchMultiLines(String longLabel, int paragraph, String chapters) async {
    final uri = Uri.parse('http://ec2-3-38-12-80.ap-northeast-2.compute.amazonaws.com/searchMul/$longLabel/$paragraph/$chapters');
    final response = await http.get(uri);
    final body = response.body;
    final jsonBody = jsonDecode(body);
    return jsonBody['text'] as List<dynamic>;
  }

  static Future<List> searchParagraph(String longLabel, int paragraph) async {
    final uri = Uri.parse('http://ec2-3-38-12-80.ap-northeast-2.compute.amazonaws.com/search/$longLabel/$paragraph');
    final response = await http.get(uri);
    final body = response.body;
    final jsonBody = jsonDecode(body);
    return jsonBody['text'] as List<dynamic>;
  }

  static Future<List> searchLongLabel(String longLabel) async {
    final uri = Uri.parse('http://ec2-3-38-12-80.ap-northeast-2.compute.amazonaws.com/search/$longLabel');
    final response = await http.get(uri);
    final body = response.body;
    final jsonBody = jsonDecode(body);
    return jsonBody['text'] as List<dynamic>;
  }

  static Future<List> getBookCountList(String longLabel) async {
    final uri = Uri.parse('http://ec2-3-38-12-80.ap-northeast-2.compute.amazonaws.com/count/$longLabel');
    final response = await http.get(uri);
    final body = response.body;
    final jsonBody = jsonDecode(body);
    return jsonBody['result'] as List<dynamic>;
  }
}