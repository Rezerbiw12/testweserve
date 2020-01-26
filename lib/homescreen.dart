import 'dart:async';
import 'package:random_color/random_color.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'albumscreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

RandomColor _randomColor = RandomColor();

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  Color _color = _randomColor.randomColor();
  Future<void> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _color = _randomColor.randomColor();
    });
    return null;
  }

  Orientation orientation;
  get() async {
    var url = "https://jsonplaceholder.typicode.com/albums";
    var res = await http.get(url);
    var map = json.decode(utf8.decode(res.bodyBytes));
    print("${map}");
    setState(() {
      data = map;
    });
  }

  var data;

  @override
  void initState() {
    get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('WESERVE Mo. Test'),
          centerTitle: true,
        ),
        body: LiquidPullToRefresh(
            showChildOpacityTransition: false,
            key: _refreshIndicatorKey,
            onRefresh: _handleRefresh,
            child: GridView.builder(
              itemCount: data == null ? 0 : data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      (orientation == Orientation.portrait) ? 2 : 2),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AlbumsScreen(data[index]))).then((value) {
                        setState(() {
                          _color = _randomColor.randomColor();
                        });
                      });
                    },
                    child: Card(
                      child: GridTile(
                          child: Container(
                        color: _color,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Albums ${data[index]['id'].toString()}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(data[index]['title'])
                          ],
                        ),
                      )),
                    ));
              },
            )));
  }
}
