import 'package:flutter/material.dart';

class TestLayout extends StatefulWidget {
  @override
  _TestLayoutState createState() => _TestLayoutState();
}

class _TestLayoutState extends State<TestLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Test Layout'),
          centerTitle: true,
        ),
        body: GestureDetector(
          child: Card(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Image.network(
                        'https://i.pinimg.com/originals/50/1f/42/501f422209322ff486f554e6f2422dd0.jpg'),
                    height: 120,
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Container(
                        color: Colors.blue,
                        height: 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Photo at albumId:'),
                            Text('title')
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ));
  }
}
