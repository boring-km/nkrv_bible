import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nkrv_bible/api/bible_api.dart';
import 'package:nkrv_bible/data/bible_book_count.dart';
import 'package:nkrv_bible/data/bible_item.dart';
import 'package:nkrv_bible/data/check_bible_is_new.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class BibleScreen extends StatefulWidget {

  final String? label;

  const BibleScreen({Key? key, this.label}) : super(key: key);

  @override
  State createState() => _BibleScreenState();
}

class _BibleScreenState extends State<BibleScreen> {

  final Logger logger = Logger();

  final List<BibleItem> dataList = [];
  final List<BibleBookCount> bookCountList = [];
  final List<Widget> textListView = [];
  final List<Widget> chapterListView = [];
  final textScrollController = ScrollController();
  final chapterScrollController = ScrollController();

  bool isFolded = false;
  double bottomBarHeight = 90;
  bool isOldBible = true;
  String curLabel = '';
  Color baseColor = Colors.blue;
  final double toolBarHeight = 50;

  late AutoScrollController autoScrollController;

  bool isReady = false;

  @override
  void initState() {
    autoScrollController = AutoScrollController(
      viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
      axis: Axis.vertical,
    );
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

    // 구약 신약에 따라 기본 색 변경
    baseColor = isNewTestament(label) ? Colors.redAccent : Colors.blue;

    // 데이터 조회
    dataList.addAll(await BibleAPI.searchLongLabel(label));
    bookCountList.addAll(await BibleAPI.getBookCountList(label));

    // 데이터 리스트 뷰
    textListView.addAll(buildTextListView(context, dataList));
    chapterListView.addAll(buildChapterListView(context, bookCountList, baseColor));

    // 현재 라벨 기록
    setState(() {
      curLabel = label;
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
        title: Text(curLabel, style: TextStyle(fontSize: base/3, fontWeight: FontWeight.bold),),
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
                      controller: autoScrollController,
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

  List<Widget> buildTextListView(BuildContext context, List<BibleItem> dataList) {
    final resultList = <Widget>[];
    double w = MediaQuery.of(context).size.width;
    for (var i = 0; i < dataList.length; i++) {
      BibleItem data = dataList[i];
      resultList.add(
        _wrapScrollTag(
          index: i,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Row(
              children: [
                SizedBox(
                  width: 60,
                  child: Text(
                    '${data.chapter} : ${data.paragraph}',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 5,),
                Flexible(
                  child: SizedBox(
                    width: w-115,
                    child: Text(data.sentence,
                      softWrap: true,
                      style: const TextStyle(fontSize: 13),
                    ),
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

  Widget _wrapScrollTag({required int index, required Widget child}) =>
      AutoScrollTag(
        key: ValueKey(index),
        controller: autoScrollController,
        index: index,
        child: child,
        highlightColor: Colors.black.withOpacity(0.1),
      );

  List<Widget> buildChapterListView(BuildContext context, List<BibleBookCount> bookCountList, Color baseColor) {
    final resultList = <Widget>[];
    double w = MediaQuery.of(context).size.width;
    double textWidth = w - 120;

    for (int i = 0; i < bookCountList.length; i++) {
      var item = bookCountList[i];
      resultList.add(
        GestureDetector(
          onTap: () async {
            final length = await BibleAPI.getPreviousTextTotalLength(curLabel, i+1);
            final tempLineCount = length / textWidth * 10.5;
            int movingIndex = 0;
            for (var j = 0; j < i; j++) {
              movingIndex += bookCountList[j].count;
            }
            await autoScrollController.animateTo(tempLineCount * 20, duration: const Duration(milliseconds: 100), curve: Curves.ease);
            await autoScrollController.scrollToIndex(movingIndex, preferPosition: AutoScrollPosition.begin);
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
