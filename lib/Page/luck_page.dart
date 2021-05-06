import 'dart:async';
import 'dart:math';

import 'package:divination/Model/AdManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:web_scraper/web_scraper.dart';

class LuckPage extends StatefulWidget {
  @override
  _LuckPageState createState() => _LuckPageState();
}

class _LuckPageState extends State<LuckPage> {
  bool _spinning = false;
  Random random = Random();
  int index;
  String quote;

  List<Map<String, dynamic>> quoteList;
  final webScraper = WebScraper('https://mingyanjiaju.org');

  void _spin() async {
    HapticFeedback.mediumImpact();
    _setspin();
    await Future.delayed(Duration(seconds: random.nextInt(5)));
    _setspin();
    myInterstitial.show();
    index = random.nextInt(quoteList.length);
    quote = quoteList[index]['title'].toString();
    await Future.delayed(Duration(seconds: 1));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            backgroundColor: Colors.yellow[100].withOpacity(0.7),
            title: Center(
                child: Text(
              '轉運不代表馬上好運，世間萬秒環環相扣，要常存好心，存善德，請緊記:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            )),
            content: Text(
              quote.substring(quote.indexOf('、') + 1),
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 30),
            ),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.yellow[200], padding: EdgeInsets.all(4.0)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('返回', style: TextStyle(color: Colors.black),)),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.yellow[200], padding: EdgeInsets.all(4.0)),
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/Home');
                  },
                  child: Text('回到主頁', style: TextStyle(color: Colors.black),))
            ],
          );
        });
  }

  void _getQuote() async {
    final endpoint = '/juzi/jingdianduanju/2014/1011/847.html';
    if (await webScraper.loadWebPage(endpoint)) {
      setState(() {
        quoteList = webScraper
            .getElement('div.main > div.text01 > div.textCont > p', []);
      });
    }
  }

  void _setspin() {
    setState(() {
      _spinning = !_spinning;
    });
  }

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    MobileAds.instance.initialize();
    myInterstitial.dispose();
    myInterstitial.load();
    super.initState();
    _getQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("temple.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Stack(children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image:
                        AssetImage(_spinning ? 'windmill.gif' : 'windmill.png'),
                    fit: BoxFit.cover)),
          ),
          Positioned(
            bottom: 10,
            left: MediaQuery.of(context).size.width * 0.55 / 2,
            child: InkWell(
              onTap: _spin,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.45,
                height: MediaQuery.of(context).size.height * 0.12,
                decoration: BoxDecoration(
                    color: Colors.brown[400].withOpacity(0.95),
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                    child: Text(
                  '轉運',
                  style: TextStyle(fontSize: 50, color: Colors.white),
                  textAlign: TextAlign.center,
                )),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
