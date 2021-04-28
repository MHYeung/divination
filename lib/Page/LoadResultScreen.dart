import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:divination/Model/AdManager.dart';
import 'package:flutter/material.dart';
import 'package:divination/Model/ExplanationModel.dart';
import 'package:divination/Page/SummaryScreen.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_review/in_app_review.dart';

import 'LoadFortuneScreen.dart';

enum Availability { LOADING, AVAILABLE, UNAVAILABLE }

extension on Availability {
  String stringify() => this.toString().split('.').last;
}
class LoadResultScreen extends StatefulWidget {
  final int index;
  final int luck;
  final int times;
  final List<int> record;

  const LoadResultScreen({@required this.index, @required this.luck, @required this.times, @required this.record});
  @override
  _LoadResultScreenState createState() =>
      _LoadResultScreenState(index: index, luck: luck, times: times);
}

class _LoadResultScreenState extends State<LoadResultScreen> {
  int index;
  int luck;
  int times = 0;
  _LoadResultScreenState({@required this.index,@required this.luck, @required this.times});

  Random random = new Random();

  Future<Widget> _loadGIF2 =
    Future<Widget>.delayed(Duration(seconds: 3), () => Text('完成擲筊', style: TextStyle(fontSize: 20.0),));

  void luckTimes(value){
    if(value <3){
      times++;
    }
  }

  void buttonAction(){
    HapticFeedback.mediumImpact();
    luck = random.nextInt(2);
    Explanation.record.add(luck);
    luckTimes(times);
    Navigator.push(
      context,
      MaterialPageRoute(
          settings: RouteSettings(name: "/Page2"),
          builder: (context) =>
              LoadResultScreen(
                index: index,
                luck: luck,
                times: times,
                record: Explanation.record,
              )),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsFlutterBinding.ensureInitialized();
    MobileAds.instance.initialize();
    myInterstitial.dispose();
    myInterstitial.load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Text(' '),
        title: Text('擲筊', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        centerTitle: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        shadowColor: Colors.brown[300],
        backgroundColor: Colors.brown,
        elevation: 5.0,
        actions: [
          FlatButton.icon(
              onPressed: (){
                Explanation.record= [];
                Navigator.of(context)
                    .popUntil(ModalRoute.withName("/Home"));},
              icon: Icon(Icons.home, color: Colors.white,),
              label: Text('返回主頁', style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15.0, color: Colors.white)))
        ],
      ),
      body: Container(
        color: Colors.yellow[100],
        child: FutureBuilder(
            future: _loadGIF2,
            builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                children =[
                  Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Text('第一次: ${Explanation.describe[Explanation.record[0]]} | 第二次: ${(Explanation.record.length>1)? Explanation.describe[Explanation.record[1]]: '-'} | 第三次: ${(Explanation.record.length>2)? Explanation.describe[Explanation.record[2]]: '-'}'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: snapshot.data,
                  ),
                  Stack(
                    children: <Widget>[
                      Center(child: Column(
                        children: [
                          SizedBox(height:50.0),
                          CircularProgressIndicator(),
                        ],
                      )),
                      Center(
                        child: Container(
                          height: 200,
                          width: 250,
                          color: Colors.yellow[100],
                        ),
                      ),
                      Center(
                          child: Image.asset(Explanation.result[luck])
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Text(Explanation.describe[luck], style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(Explanation.describe[luck+3], style: TextStyle(fontSize: 25.0,),),
                  ),
                  Container(
                    height: 80,
                    width: 200,
                    padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: RaisedButton.icon(
                        color: Colors.red[100],
                        label: AutoSizeText('查看結果',maxLines: 1, style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold, color: Colors.black54)),
                        onPressed: (){
                          HapticFeedback.mediumImpact();
                          myInterstitial.show();
                          Navigator.push(
                            context,
                            MaterialPageRoute(settings: RouteSettings(name: "/Page3"),builder: (context) => SummaryScreen(index: index, luck: luck, cur: DateTime.now(), record: Explanation.record,)),
                          );
                        },
                        icon: Icon(Icons.arrow_forward_rounded),
                      ),
                    ),
                  ),
                  Container(
                    height: 80,
                    width: 200,
                    padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: RaisedButton(
                        color: Colors.red[100],
                        child: AutoSizeText('擲筊 ($times/3)', maxLines: 1,
                            style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54)),
                        onPressed: (times==3) ?  null: buttonAction
                      ),
                    ),
                  ),
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
                          Explanation.record= [];
                          HapticFeedback.mediumImpact();
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
                ];
              }else if(snapshot.hasError){
                children = [
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  )
                ];
              }else{
                children = [
                  Container(
                      height: MediaQuery.of(context).size.height*0.87,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("temple.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(child: Image.asset("assets/run_luck.gif", height: 500, width: 500,cacheHeight: 250,cacheWidth: 250,scale: 0.65))),
                ];
              }
              return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: children,
                  )
              );
            }
        ),
      ),
    );
  }
}
