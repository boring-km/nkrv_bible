import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nkrv_bible/api/bible_api.dart';
import 'package:nkrv_bible/data/bible_item.dart';
import 'package:nkrv_bible/data/new_testament.dart';
import 'package:nkrv_bible/data/old_testament.dart';

class BibleScreen extends StatefulWidget {
  const BibleScreen({Key? key}) : super(key: key);

  @override
  State createState() => _BibleScreenState();
}

class _BibleScreenState extends State<BibleScreen> {

  String longLabel = '창세기';
  final List<OldTestament> oldList = OldTestament.values;
  final List<NewTestament> newList = NewTestament.values;
  final List<BibleItem> dataList = [];

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await setBibleText('창세기');
    });
    super.initState();
  }

  Future<void> setBibleText(String label) async {
    dataList.clear();
    dataList.addAll(await BibleAPI.searchLongLabel(label));
    longLabel = label;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    double base = w > h ? w / 10 : h / 10;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Container(
                width: w - 20,
                height: h - 40,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                      child: Center(child: Text(longLabel, style: TextStyle(fontSize: base/3),),),),
                    SizedBox(
                      height: h - 80,
                      child: ListView(
                        children: buildTextListView(context),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: w - 20,
                height: 80,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2.0),
                  color: Colors.greenAccent,
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
                          final bibleLabel = getOldOrNewLabel(index);
                          return GestureDetector(
                            onTap: () async {
                              await setBibleText(bibleLabel);
                            },
                            child: Card(
                              child: Center(
                                child: Text(bibleLabel),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getOldOrNewLabel(int index) => index < 39 ? oldList[index].label : newList[index-39].label;

  List<Widget> buildTextListView(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    var result = <Widget>[];
    for (BibleItem data in dataList) {
      result.add(
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
                SizedBox(
                  width: w-100,
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

    return result;
  }
}
