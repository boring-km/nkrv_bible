import 'dart:convert';

import 'package:test/test.dart';
import 'package:http/http.dart' as http;

void main() {
  test("창세기 1장 1절 조회하기", () async {
    final longLabel = '창세기';
    final paragraph = 1;
    final chapter = 1;

    final uri = Uri.parse('http://ec2-3-38-12-80.ap-northeast-2.compute.amazonaws.com/searchOne/$longLabel/$paragraph/$chapter');
    final response = await http.get(uri);
    final body = response.body;
    final jsonBody = jsonDecode(body);
    final result = jsonBody['text'][0]['sentence'];
    expect('<천지 창조> 태초에 하나님이 천지를 창조하시니라', result);
  });
}