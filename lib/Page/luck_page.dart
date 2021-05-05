import 'dart:async';
import 'dart:math';

import 'package:divination/Model/AdManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class LuckPage extends StatefulWidget {
  @override
  _LuckPageState createState() => _LuckPageState();
}

class _LuckPageState extends State<LuckPage> {
  bool _spinning = false;
  Random random = Random();

  void _spin() async {
    HapticFeedback.mediumImpact();
    _setspin();
    await Future.delayed(Duration(seconds: random.nextInt(5)));
    _setspin();
    myInterstitial.show();
    await Future.delayed(Duration(seconds: 1));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white.withOpacity(0.7),
            title: Text(
              '風車轉運',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            content: Text(
              'bla bla blaasd afafWQRVGATTRBAGFD VSRBT GVSDFV efas sdsvdtggf afd gagsfewfkltgheithisdf tis  oa  aikfhjkqnjkbqbf',
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 25),
            ),
            actions: [
             ElevatedButton(onPressed: (){Navigator.pop(context);}, child: Text('exit')),
             ElevatedButton(onPressed: (){Navigator.popAndPushNamed(context, '/Home');}, child: Text('Home'))
            ],
          );
        });
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
