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

  test("창세기 1장 1-3절 조회하기", () async {
    final longLabel = '창세기';
    final paragraph = 1;
    final chapter = '1-3';
    final uri = Uri.parse('http://ec2-3-38-12-80.ap-northeast-2.compute.amazonaws.com/searchMul/$longLabel/$paragraph/$chapter');
    final response = await http.get(uri);
    final body = response.body;
    final jsonBody = jsonDecode(body);
    final resultArray = jsonBody['text'];
    expect('<천지 창조> 태초에 하나님이 천지를 창조하시니라', resultArray[0]['sentence']);
    expect('땅이 혼돈하고 공허하며 흑암이 깊음 위에 있고 하나님의 영은 수면 위에 운행하시니라', resultArray[1]['sentence']);
    expect('하나님이 이르시되 빛이 있으라 하시니 빛이 있었고', resultArray[2]['sentence']);
    // expect('<천지 창조> 태초에 하나님이 천지를 창조하시니라', result);
  });

}