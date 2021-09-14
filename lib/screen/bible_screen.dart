import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nkrv_bible/api/bible_api.dart';
import 'package:nkrv_bible/data/bible_book_count.dart';
import 'package:nkrv_bible/data/bible_item.dart';
import 'package:nkrv_bible/data/new_testament.dart';
import 'package:nkrv_bible/data/old_testament.dart';

class BibleScreen extends StatefulWidget {

  final String? label;

  const BibleScreen({Key? key, this.label}) : super(key: key);

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
  double bottomBarHeight = 90;
  bool isOldBible = true;
  String longLabel = '';
  Color baseColor = Colors.blue;
  final double toolBarHeight = 50;

  bool isReady = false;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await setBibleText(widget.label!);
    });
    super.initState();
  }

  Future<void> setBibleText(String label) async {

    setState(() {
      isReady = false;
    });

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
      isReady = true;
    });

  }

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double safePadding = MediaQuery.of(context).padding.top + MediaQuery.of(context).padding.bottom + toolBarHeight;
    double fullHeight = MediaQuery.of(context).size.height;
    double h = fullHeight - safePadding;
    double base = w > h ? w / 10 : h / 10;
    var listHeight = !isFolded ? h - bottomBarHeight : fullHeight;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: baseColor,
        title: Text(longLabel, style: TextStyle(fontSize: base/3, fontWeight: FontWeight.bold),),
        toolbarHeight: toolBarHeight,
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
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: AnimatedContainer(
                height: listHeight,
                duration: const Duration(milliseconds: 300),
                child: SizedBox(
                  width: w-50,
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
            SizedBox(
              height: listHeight,
              child: Align(
                alignment: Alignment.topRight,
                child: AnimatedContainer(
                  width: 50,
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
                                        isOld ? const Text('구', style: TextStyle(color: Colors.blue, fontSize: 16),)
                                            : const Text('신', style: TextStyle(color: Colors.red, fontSize: 16),),
                                        const SizedBox(height: 4.0,),
                                        Text(bibleLabel, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
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
            !isReady ? Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  color: baseColor,
                  strokeWidth: 4.0,
                ),
              ),
            ) : const SizedBox(),
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
          child: Row(
            children: [
              SizedBox(
                width: 55,
                child: Text(
                  '${data.chapter} : ${data.paragraph}',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Flexible(
                child: Container(
                  width: w-200,
                  child: Text(data.sentence,
                    softWrap: true,
                  ),
                ),
              ),
            ],
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
            height: 40,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border(bottom: BorderSide(color: baseColor, width: 0.5)),
            ),
            child: Center(
              child: Text('${item.chapter}',
                style: TextStyle(color: baseColor, fontSize: 20, fontWeight: FontWeight.bold),),),
          ),
        ),
      );
    }
    return resultList;
  }
}
