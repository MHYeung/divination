import 'dart:async';
import 'package:divination/Model/AdManager.dart';
import 'package:divination/Page/luck_page.dart';
import 'package:flutter/material.dart';
import 'Page/Explanation.dart';
import 'Page/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  runApp(MaterialApp(
      initialRoute: '/Home',
      routes: {'/Home':(context) => Home()}
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _currentIndex = 0;
  final List<Widget> pageName = [
    HomePage(),
    LuckPage(),
  ];

  void onTapped(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('每日一籤', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        centerTitle: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        shadowColor: Colors.brown[300],
        backgroundColor: Colors.brown,
        elevation: 5.0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.yellow[100],
        selectedItemColor: Colors.amber[800],
        selectedFontSize:15.0,
        unselectedFontSize: 13.0,
        selectedIconTheme: IconThemeData(size: 30.0),
        unselectedIconTheme: IconThemeData(size: 25.0),
        currentIndex: _currentIndex,
        onTap: onTapped,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('求籤'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.text_fields_sharp),
            title: new Text('風車轉運'),
          ),
        ],
      ),
      body: pageName[_currentIndex],
    );
  }
}
