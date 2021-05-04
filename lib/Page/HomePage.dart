import 'dart:math';
import 'package:divination/Model/AdManager.dart';
import 'package:flutter/material.dart';
import 'package:divination/Page/LoadFortuneScreen.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../main.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Random random = new Random();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height-100,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("temple.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(left: 5.0, right: 5.0),
                  padding: EdgeInsets.all(28.0),
                  decoration: new BoxDecoration(
                    color: Colors.white.withOpacity(0.75),
                  ),
                  child: AutoSizeText('請虔誠地在心中默念您的姓名、出生年月日、住址後，誠心祈求觀音佛祖，指點迷津，將您心中想請教的事情詳細說明後，再點選"立即求籤"按鈕進行線上求籤。',
                    maxLines: 8,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25.0),
              Container(
                height: 150,
                width: 200,
                padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: RaisedButton(
                    color: Colors.red[100],
                    child: AutoSizeText('立即求籤',
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54)),
                    onPressed: () {
                      HapticFeedback.mediumImpact();
                      Navigator.push(
                        context,
                        MaterialPageRoute(settings: RouteSettings(name: "/Page1"),builder: (context) => LoadFortuneScreen(index: random.nextInt(59))),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
