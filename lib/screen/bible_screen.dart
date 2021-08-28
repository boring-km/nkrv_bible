import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nkrv_bible/data/new_testament.dart';
import 'package:nkrv_bible/data/old_testament.dart';
import 'package:nkrv_bible/res/CustomColors.dart';

class BibleScreen extends StatelessWidget {

  const BibleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: CustomColors.beige,
                  border: Border.all(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(4.0)
              ),
              child: ListView(
                  children: _buildTestamentList()
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTestamentList() {
    final textList = <Widget>[];
    final labelList = [];
    labelList.add('구약성서');
    labelList.addAll(OldTestament.values);
    labelList.add('신약성서');
    labelList.addAll(NewTestament.values);
    for (dynamic item in labelList) {
      if (item is OldTestament) {
        final OldTestament ot = item;
        textList.add(
            Text(
              ot.label,
              style: TextStyle(fontSize: 12),
            )
        );
      } else if (item is NewTestament) {
        final NewTestament nt = item;
        textList.add(
            Text(
              nt.label,
              style: const TextStyle(fontSize: 12),
            )
        );
      } else {
        textList.add(
            Text(
              item,
              style: const TextStyle(fontSize: 20),
            )
        );
      }

    }
    return textList;
  }

}