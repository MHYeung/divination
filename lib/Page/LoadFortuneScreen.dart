import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:divination/Model/ExplanationModel.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:divination/Page/LoadResultScreen.dart';
import 'package:flutter/services.dart';

class LoadFortuneScreen extends StatefulWidget {
  final int index;
  const LoadFortuneScreen({@required this.index});

  @override
  _LoadFortuneScreenState createState() => _LoadFortuneScreenState(index);
}

class _LoadFortuneScreenState extends State<LoadFortuneScreen> {
  int index;
  _LoadFortuneScreenState(this.index);

  Random random = new Random();

  Future<Widget> _loadGIF = Future<Widget>.delayed(
      Duration(seconds: 3),
      () => Text(
            '求籤完成',
            style: TextStyle(fontSize: 30.0),
          ));

  void action() {
    HapticFeedback.mediumImpact();
    int luck = random.nextInt(2);
    Explanation.record.add(luck);
    Navigator.push(
        context,
        MaterialPageRoute(
            settings: RouteSettings(name: "/Page2"),
            builder: (context) => LoadResultScreen(
                  index: index,
                  luck: luck,
                  times: 1,
                  record: Explanation.record,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Text(' '),
        title: Text(
          '求籤',
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
        child: FutureBuilder(
            future: _loadGIF,
            builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                children = [
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: snapshot.data,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Stack(
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
                          image: Explanation.stick[index],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Container(
                      child: Text(
                        '第${index + 1}籤',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 80,
                    width: 150,
                    padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: RaisedButton(
                        color: Colors.red[100],
                        child: Text('擲筊',
                            style: TextStyle(
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54)),
                        onPressed: action,
                      ),
                    ),
                  ),
                ];
              } else if (snapshot.hasError) {
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
              } else {
                children = [
                  Container(
                      height: MediaQuery.of(context).size.height * 0.87,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("temple.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                          child: Image.asset(
                        "assets/run_fortune.gif",
                        height: 300,
                        width: 300,
                        cacheHeight: 250,
                        cacheWidth: 250,
                      ))),
                ];
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: children,
                ),
              );
            }),
      ),
    );
  }
}
