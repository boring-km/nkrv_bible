import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nkrv_bible/data/new_testament.dart';
import 'package:nkrv_bible/data/old_testament.dart';
import 'package:nkrv_bible/res/custom_colors.dart';

class BookSelectScreen extends StatelessWidget {

  const BookSelectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    print("$w $h");
    const base = 8.0;
    const baseAllPadding = const EdgeInsets.all(base);

    var landscapeView = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: w/2 - base*8,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(4.0),
                  topLeft: Radius.circular(4.0),
                ),
              ),
              child: Center(
                child: Text("구약성서",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: CustomColors.beige,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(4.0),
                    bottomRight: Radius.circular(4.0),
                  )
              ),
              width: w/2 - base*8,
              height: h - base*2 - 120,
              child: Padding(
                padding: baseAllPadding,
                child: ListView(
                  children: _buildTestamentList(OldTestament.values),
                ),
              ),
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: w/2 - base*8,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(4.0),
                  topLeft: Radius.circular(4.0),
                ),
              ),
              child: Center(
                child: Text("신약성서",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: CustomColors.beige,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(4.0),
                    bottomRight: Radius.circular(4.0),
                  )
              ),
              width: w/2 - base*8,
              height: h - base*2 - 120,
              child: Padding(
                padding: baseAllPadding,
                child: ListView(
                  children: _buildTestamentList(NewTestament.values),
                ),
              ),
            ),
          ],
        ),
      ],
    );

    var portraitView = ListView(
      scrollDirection: Axis.vertical,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: w - base*2,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(4.0),
                  topLeft: Radius.circular(4.0),
                ),
              ),
              child: Center(
                child: Text("구약성서",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: CustomColors.beige,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(4.0),
                    bottomRight: Radius.circular(4.0),
                  )
              ),
              width: w - base*2,
              child: Padding(
                padding: baseAllPadding,
                child: Column(
                  children: _buildTestamentList(OldTestament.values),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: base,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: w - base*2,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(4.0),
                  topLeft: Radius.circular(4.0),
                ),
              ),
              child: Center(
                child: Text("신약성서",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: CustomColors.beige,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(4.0),
                    bottomRight: Radius.circular(4.0),
                  )
              ),
              width: w - base*2,
              child: Padding(
                padding: baseAllPadding,
                child: Column(
                  children: _buildTestamentList(NewTestament.values),
                ),
              ),
            ),
          ],
        ),
      ],
    );
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: w > h ? landscapeView : portraitView,
        ),
      ),
    );
  }

  List<Widget> _buildTestamentList(List<dynamic> values) {
    final textList = <Widget>[];
    if (values[0] is OldTestament) {
      for (OldTestament item in values) {
        textList.add(
            InkWell(
              onTap: () {
                // TODO 선택한 책 이름과 몇 장(편)인지 선택
                print(item.label);
              },
              child: Text(
                item.label,
                style: const TextStyle(fontSize: 28),
              ),
            )
        );
      }
    } else {
      for (NewTestament item in values) {
        textList.add(
            InkWell(
              onTap: () {
                // TODO 선택한 책 이름과 몇 장(편)인지 선택
                print(item.label);
              },
              child: Text(
                item.label,
                style: const TextStyle(fontSize: 28),
              ),
            )
        );
      }
    }

    return textList;
  }

}