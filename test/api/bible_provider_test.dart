import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:nkrv_bible/data/bible_item.dart';
import 'package:nkrv_bible/data/result.dart';
import 'package:nkrv_bible/provider/bible_provider.dart';

void main() {
  BibleProvider provider = BibleProvider();
  Logger logger = Logger();

  test("창세기 1장 1절 조회하기", () async {
    String data = await provider.searchOne('창세기', 1, 1);
    expect('태초에 하나님이 천지를 창조하시니라', data);
  });

  test("창세기 1장 1-3절 조회하기", () async {
    const paragraph = 1;
    const chapters = '1-3';
    var successResult = (await provider.searchMultiLines('창세기', paragraph, chapters)) as Success<List<BibleItem>>;
    final resultArray = successResult.data;
    expect(resultArray[0].sentence, '태초에 하나님이 천지를 창조하시니라');
    expect(resultArray[1].sentence, '땅이 혼돈하고 공허하며 흑암이 깊음 위에 있고 하나님의 영은 수면 위에 운행하시니라');
    expect(resultArray[2].sentence, '하나님이 이르시되 빛이 있으라 하시니 빛이 있었고');
  });

  test("창세기 1장 전체를 조회하면 31절까지 있다", () async {
    const paragraph = 1;
    final resultArray = await provider.searchParagraph('창세기', paragraph);
    expect(resultArray.length, 31);
  });

  test("창세기 전체를 조회하면 총 1533절이 있다", () async {
    final resultArray = await provider.searchLongLabel('창세기');
    expect(1533, resultArray.length);
  });

  test("창세기는 50장까지 있다", () async {
    final resultList = await provider.getBookCountList('창세기');
    for (var count in resultList) {
      logger.i('${count.chapter}장은 ${count.count}절까지 있다.');
    }
    expect(resultList.length, 50);
  });

  test("시편 100편 앞까지 있었던 시편의 문자 수의 합은 70713자 이다.", () async {
    const label = '시편';
    const chapter = 100;
    final result = await provider.getPreviousTextTotalLength(label, chapter);
    expect(result, 70713);
  });
}
