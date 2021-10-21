import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nkrv_bible/data/new_testament.dart';
import 'package:nkrv_bible/data/old_testament.dart';
import 'package:nkrv_bible/res/custom_colors.dart';
import 'package:nkrv_bible/screen/bible_screen.dart';
class BookSelectScreen extends StatefulWidget {

  const BookSelectScreen({Key? key}) : super(key: key);

  @override
  State<BookSelectScreen> createState() => _BookSelectScreenState();
}

class _BookSelectScreenState extends State<BookSelectScreen> {

  final Logger logger = Logger();
  final base = 8.0;
  final baseAllPadding = const EdgeInsets.all(8.0);
  static const oldBookLength = 39;
  static const newBookLength = 27;
  static const bibleBookLength = oldBookLength + newBookLength;

  List<bool> indexList = List<bool>.filled(bibleBookLength, false, growable: false);
  List<String> bookLabelList = List<String>.filled(bibleBookLength, "", growable: false);
  int selectedIndex = 0;

  @override
  void initState() {
    setBookLabelList();
    super.initState();
  }

  void setBookLabelList() {
    for (var i = 0; i < oldBookLength; i++) {
      bookLabelList[i] = OldTestament.values[i].label;
    }
    for (var i = 0; i < newBookLength; i++) {
      bookLabelList[i+oldBookLength] = NewTestament.values[i].label;
    }
  }

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    var portraitView = Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(base * 4))
      ),
      width: w - base*2,
      height: h,
      child: buildListWheelScrollView(),
    );
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: [
            Center(child: portraitView),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(right: base * 2, bottom: base * 2),
                child: FloatingActionButton(
                  onPressed: () {
                    Get.to(BibleScreen(label: bookLabelList[selectedIndex],));
                  },
                  child: const Icon(CupertinoIcons.search),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListWheelScrollView buildListWheelScrollView() {
    return ListWheelScrollView(
      itemExtent: 50,
      diameterRatio: 6,
      onSelectedItemChanged: (index) {
        setState(() {
          for (int i = 0; i < bibleBookLength; i++) {
            i == index ? indexList[i] = true : indexList[i] = false;
          }
          selectedIndex = index;
        });
      },
      children: buildList(baseAllPadding),
    );
  }

  List<Widget> buildList(EdgeInsets baseAllPadding) {
    var resultList = <Widget>[];

    for (int i = 0; i < bibleBookLength; i++) {
      String label = bookLabelList[i];
      bool isOld = i < oldBookLength;

      double defaultFontSize = 18;
      String forwardLabel = isOld ? '구약' : '신약';
      var forwardLabelColor = isOld ? Color(0xff074ff6) : Color(0xfffa1313);
      var isSelected = indexList[i] == true;
      var boxDecoration = const BoxDecoration();

      if (isSelected) {
        boxDecoration = BoxDecoration(
          color: isOld ? CustomColors.lightBlue : CustomColors.lightRed,
        );
        defaultFontSize = 36;
      }

      resultList.add(
          Container(
            decoration: boxDecoration,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: base),
                    child: Text(
                      forwardLabel,
                      style: TextStyle(color: forwardLabelColor),
                    ),
                  ),
                  Text(
                    label,
                    style: TextStyle(fontSize: defaultFontSize),
                  ),
                  const SizedBox(width: 5,)
                ],
              ),
            ),
          )
      );
    }
    return resultList;
  }
}
