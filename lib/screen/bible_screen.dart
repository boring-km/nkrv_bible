import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nkrv_bible/api/bible_api.dart';
import 'package:nkrv_bible/data/bible_book_count.dart';
import 'package:nkrv_bible/data/bible_item.dart';
import 'package:nkrv_bible/data/new_testament.dart';
import 'package:nkrv_bible/data/old_testament.dart';

class BibleScreen extends StatefulWidget {
  const BibleScreen({Key? key}) : super(key: key);

  @override
  State createState() => _BibleScreenState();
}

class _BibleScreenState extends State<BibleScreen> {

  final Logger logger = Logger();

  final List<OldTestament> oldList = OldTestament.values;
  final List<NewTestament> newList = NewTestament.values;
  final List<BibleItem> dataList = [];
  final List<BibleBookCount> bookCountList = [];
  final List<Widget> textListView = [];
  final List<Widget> chapterListView = [];
  final textScrollController = ScrollController();
  final chapterScrollController = ScrollController();

  bool isFolded = false;
  double bottomBarHeight = 80;
  bool isOldBible = true;
  String longLabel = '창세기';
  Color baseColor = Colors.blue;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await setBibleText('창세기');
    });
    super.initState();
  }

  Future<void> setBibleText(String label) async {
    // 기존 데이터 지우기
    dataList.clear();
    textListView.clear();
    bookCountList.clear();
    chapterListView.clear();

    // 기본 색 변경
    baseColor = isOldBible ? Colors.blue : Colors.redAccent;

    // 데이터 조회
    dataList.addAll(await BibleAPI.searchLongLabel(label));
    bookCountList.addAll(await BibleAPI.getBookCountList(label));

    // 데이터 리스트 뷰
    textListView.addAll(buildTextListView(context, dataList));
    chapterListView.addAll(buildChapterListView(context, bookCountList, baseColor));

    // 스크롤 당기기
    chapterScrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.ease);
    textScrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.ease);

    // 현재 라벨 기록
    setState(() {
      longLabel = label;
    });

  }

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    double base = w > h ? w / 10 : h / 10;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: baseColor,
        title: Text(longLabel, style: TextStyle(fontSize: base/3, fontWeight: FontWeight.bold),),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.eye, color: Colors.white,),
            onPressed: () {
              setState(() {
                isFolded = !isFolded;
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            AnimatedContainer(
              width: w-40,
              height: !isFolded ? h - (bottomBarHeight*2 - 120) : h - 40,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              duration: const Duration(milliseconds: 300),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: AnimatedContainer(
                  height: !isFolded ? h - bottomBarHeight*2 : h - bottomBarHeight - 20,
                  duration: const Duration(milliseconds: 300),
                  child: SizedBox(
                    width: w-40,
                    child: Scrollbar(
                      child: ListView.builder(
                        controller: textScrollController,
                        itemCount: textListView.length,
                        itemBuilder: (innerContext, index) {
                          return textListView[index];
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: AnimatedContainer(
                width: 40,
                duration: const Duration(milliseconds: 300),
                child: Scrollbar(
                  child: ListView.builder(
                    controller: chapterScrollController,
                    itemCount: chapterListView.length,
                    itemBuilder: (innerContext, index) {
                      return chapterListView[index];
                    },
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: !isFolded ? Container(
                  width: w,
                  height: !isFolded ? bottomBarHeight : 0,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                  ),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 66,
                          itemBuilder: (BuildContext context, int index) {
                            final Map<Object, Object> data = getOldOrNewLabel(index);
                            final String bibleLabel = data['label'].toString();
                            final bool isOld = data['isOld'] as bool;
                            return GestureDetector(
                              onTap: () async {
                                isOldBible = isOld;
                                await setBibleText(bibleLabel);
                              },
                              child: Card(
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        isOld ? const Text('구', style: TextStyle(color: Colors.blue),) :
                                        const Text('신', style: TextStyle(color: Colors.red),),
                                        const SizedBox(height: 4.0,),
                                        Text(bibleLabel, style: const TextStyle(fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ) : const SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<Object, Object> getOldOrNewLabel(int index) {
    var isOld = index < 39;
    String label = isOld ? oldList[index].label : newList[index-39].label;
    return {"isOld": isOld, "label": label};
  }

  List<Widget> buildTextListView(BuildContext context, List<BibleItem> dataList) {
    final resultList = <Widget>[];
    double w = MediaQuery.of(context).size.width;
    for (BibleItem data in dataList) {
      resultList.add(
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: SizedBox(
            child: Row(
              children: [
                SizedBox(
                  width: 60,
                  child: Text(
                    '${data.chapter} : ${data.paragraph}',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 10,),
                SizedBox(
                  width: w-120,
                  child: Text(data.sentence,
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return resultList;
  }

  List<Widget> buildChapterListView(BuildContext context, List<BibleBookCount> bookCountList, Color baseColor) {
    final resultList = <Widget>[];
    for (int i = 0; i < bookCountList.length; i++) {
      var item = bookCountList[i];
      resultList.add(
        GestureDetector(
          onTap: () {
            logger.d('선택한 장: ${i+1}');
          },
          child: Container(
            height: 30,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border(bottom: BorderSide(color: baseColor, width: 0.5)),
            ),
            child: Center(
              child: Text('${item.chapter}',
                style: TextStyle(color: baseColor, fontWeight: FontWeight.bold),),),
          ),
        ),
      );
    }
    return resultList;
  }
}
