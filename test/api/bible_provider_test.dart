import 'package:nkrv_bible/data/bible_item.dart';
import 'package:nkrv_bible/provider/bible_provider.dart';
import 'package:test/test.dart';

void main() {

  final localUrl = 'http://192.168.35.2:3000';

  BibleProvider provider = BibleProvider();

  test("창세기 1장 1절 조회하기", () async {
    String data = await provider.searchOne('창세기', 1, 1);
    expect('태초에 하나님이 천지를 창조하시니라', data);
  });
}