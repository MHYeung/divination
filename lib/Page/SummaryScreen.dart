import 'dart:async';
import 'dart:math';
import 'package:divination/Model/AdManager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:divination/Model/ExplanationModel.dart';
import 'package:divination/Page/LoadFortuneScreen.dart';
import 'package:flutter/services.dart';
import 'package:auto_size_text/auto_size_text.dart';

class SummaryScreen extends StatefulWidget {
  final int index;
  final int luck;
  final DateTime cur;
  final List<int> record;

  const SummaryScreen({Key key, this.index, this.luck, this.cur, this.record})
      : super(key: key);

  @override
  _SummaryScreenState createState() =>
      _SummaryScreenState(index: index, luck: luck, cur: cur);
}

class _SummaryScreenState extends State<SummaryScreen> {
  int index;
  int luck;
  DateTime cur;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  Random random = new Random();

  _SummaryScreenState({this.index, this.luck, this.cur});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Text(' '),
        title: Text(
          '結果總覽',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        shadowColor: Colors.brown[300],
        backgroundColor: Colors.brown,
        elevation: 5.0,
        actions: [
          FlatButton.icon(
              onPressed: () {
                Explanation.record = [];
                Navigator.of(context).popUntil(ModalRoute.withName("/Home"));
              },
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              label: Text('返回主頁',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15.0,
                      color: Colors.white)))
        ],
      ),
      body: Container(
        color: Colors.yellow[100],
        child: ListView(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '籤詩解讀',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                child: Text('求籤時間:  ${dateFormat.format(cur)}'),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
                child: Stack(
                  children: <Widget>[
                    Center(
                        child: Column(
                          children: [
                              SizedBox(height: 50.0),
                              CircularProgressIndicator(),
                      ],
                    )),
                    Center(
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: Explanation.content[index],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    flex:2,
                      child: AutoSizeText('第一次: ${Explanation.describe[Explanation.record[0]]} | 第二次: ${(Explanation.record.length>1)? Explanation.describe[Explanation.record[1]]: '-'} | 第三次: ${(Explanation.record.length>2)? Explanation.describe[Explanation.record[2]]: '-'}',
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 35.0, fontWeight: FontWeight.bold))),
                ],
              ),
             /* Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  Explanation.describe[luck + 3],
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
              ),*/
              SizedBox(height: 35),
              Container(
                height: 80,
                width: 200,
                padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: RaisedButton.icon(
                    color: Colors.red[100],
                    label: AutoSizeText('再求一次',
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54)),
                    onPressed: () {
                      HapticFeedback.mediumImpact();
                      Explanation.record = [];
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            settings: RouteSettings(name: "/Page3"),
                            builder: (context) =>
                                LoadFortuneScreen(index: random.nextInt(59)),
                          ));
                    },
                    icon: Icon(Icons.redo),
                  ),
                ),
              ),
              SizedBox(height: 35),
            ],
          ),
        ]),
      ),
    );
  }
}
