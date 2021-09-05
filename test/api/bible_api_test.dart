import 'package:logger/logger.dart';
import 'package:nkrv_bible/api/bible_api.dart';
import 'package:test/test.dart';

void main() {

  const longLabel = '창세기';
  var logger = Logger();

  test("창세기 1장 1절 조회하기", () async {
    const paragraph = 1;
    const chapter = 1;
    final result = await BibleAPI.searchOne(longLabel, paragraph, chapter);
    expect('<천지 창조> 태초에 하나님이 천지를 창조하시니라', result);
  });

  test("창세기 1장 1-3절 조회하기", () async {
    const paragraph = 1;
    const chapters = '1-3';
    final resultArray = await BibleAPI.searchMultiLines(longLabel, paragraph, chapters);
    expect('<천지 창조> 태초에 하나님이 천지를 창조하시니라', resultArray[0].sentence);
    expect('땅이 혼돈하고 공허하며 흑암이 깊음 위에 있고 하나님의 영은 수면 위에 운행하시니라', resultArray[1].sentence);
    expect('하나님이 이르시되 빛이 있으라 하시니 빛이 있었고', resultArray[2].sentence);
  });

  test("창세기 1장 전체를 조회하면 31절까지 있다", () async {
    const paragraph = 1;
    final resultArray = await BibleAPI.searchParagraph(longLabel, paragraph);
    expect(31, resultArray.length);
  });

  test("창세기 전체를 조회하면 총 1533절이 있다", () async {
    final resultArray = await BibleAPI.searchLongLabel(longLabel);
    expect(1533, resultArray.length);
  });

  test("창세기는 50장까지 있다", () async {
    final resultList = await BibleAPI.getBookCountList(longLabel);
    for (var count in resultList) {
      logger.i('${count.chapter}장은 ${count.count}절까지 있다.');
    }
    expect(50, resultList.length);
  });
}