import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nkrv_bible/data/new_testament.dart';
import 'package:nkrv_bible/data/old_testament.dart';
import 'package:nkrv_bible/res/custom_colors.dart';
class BookSelectScreen extends StatefulWidget {

  const BookSelectScreen({Key? key}) : super(key: key);

  @override
  State<BookSelectScreen> createState() => _BookSelectScreenState();
}

class _BookSelectScreenState extends State<BookSelectScreen> {

  final Logger logger = Logger();
  final base = 8.0;
  final baseAllPadding = const EdgeInsets.all(8.0);
  static const bibleBookLength = 66;

  List<bool> indexList = List<bool>.filled(bibleBookLength, false, growable: false);
  List<String> textList = List<String>.filled(bibleBookLength, "", growable: false);
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    var portraitView = Container(
      decoration: const BoxDecoration(
          color: CustomColors.beige,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16.0),
            bottomRight: Radius.circular(16.0),
          )
      ),
      width: w - base*2,
      height: h - base*4,
      child: buildListWheelScrollView(),
    );
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              portraitView,
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(right: base * 2, bottom: base * 2),
                  child: FloatingActionButton(
                    onPressed: () {
                      logger.d("hello: ${textList[selectedIndex]}");
                    },
                    child: const Icon(CupertinoIcons.search),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListWheelScrollView buildListWheelScrollView() {
    return ListWheelScrollView(
      itemExtent: 50,
      diameterRatio: 3,
      useMagnifier: true,
      magnification: 1.3,
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
    var list = [];
    list.addAll(OldTestament.values);
    list.addAll(NewTestament.values);

    for (int i = 0; i < bibleBookLength; i++) {
      var item = list[i];
      OldTestament? oldT = item is OldTestament ? item : null;
      NewTestament? newT = oldT == null ? item : null;
      String label = oldT != null ? oldT.label : newT!.label;
      textList[i] = label;

      resultList.add(
          indexList[i] == true ? Container(
            decoration: const BoxDecoration(
              color: Color(0xBEFFFFFF),
            ),
            height: 50,
            child: Center(
              child: Text(
                label,
                style: const TextStyle(fontSize: 28),
              ),
            ),
          ) : Container(
            decoration: null,
            height: 50,
            child: Center(
              child: Text(
                label,
                style: const TextStyle(fontSize: 28),
              ),
            ),
          )
      );
    }
    return resultList;
  }
}
