import 'package:flutter/material.dart';
import 'package:divination/Model/ExplanationModel.dart';


class ExplanationPage extends StatefulWidget {

  @override
  _ExplanationPageState createState() => _ExplanationPageState();
}

class _ExplanationPageState extends State<ExplanationPage> {

  int dropdownValue = 1;

  void next(){
    setState(() {
      if(dropdownValue<Explanation.content.length){
        dropdownValue++;
      }
    });
  }

  void previous(){
    setState(() {
      if(dropdownValue>0){
        dropdownValue--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      body: ListView(
        padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
        semanticChildCount: 5,
        children: [
          ListTile(
              selectedTileColor: Colors.brown,
              contentPadding: EdgeInsets.fromLTRB(2.0, 0.0, 2.0, 2.0),
              onTap: (){},
              subtitle: Image.network(
                Explanation.content[dropdownValue-1],
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress){
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded/loadingProgress.expectedTotalBytes : null,
                    ),
                  );
                },

              )),
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(40.0,5.0,40.0,0.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            title: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedButton(
                    onPressed: previous,
                    color: Colors.purple[100],
                    child: Text('上一籤'),
                  ),
                  SizedBox(width: 20.0),
                  Text('第'),
                  SizedBox(width: 7.0),
                  DropdownButton(
                    value: dropdownValue,
                    icon: SizedBox(
                        width: 10.0,
                        child: Icon(Icons.arrow_drop_down)),
                    iconSize: 16.0,
                    elevation: 3,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    onChanged: (int newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60]
                        .map<DropdownMenuItem<int>>((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text('$value', textAlign: TextAlign.end),
                      );
                    })
                        .toList(),
                  ),
                  SizedBox(width: 5.0),
                  Text('籤'),
                  SizedBox(width: 20.0),
                  RaisedButton(
                    onPressed: next,
                    color: Colors.purple[100],
                    child: Text('下一籤'),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}