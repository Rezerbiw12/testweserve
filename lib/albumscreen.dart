import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AlbumsScreen extends StatefulWidget {
  final data;
  AlbumsScreen(this.data);
  @override
  _AlbumsScreenState createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  album() async {
    var a = "https://jsonplaceholder.typicode.com/photos?albumId=";
    var b = "${widget.data['id']}";
    var url = a + b;
    var res = await http.get(url);
    var map = json.decode(utf8.decode(res.bodyBytes));
    setState(() {
      albums = map;
    });
  }

  var albums;

  @override
  void initState() {
    album();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data['title']),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView.builder(
        itemCount: albums == null ? 0 : albums.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Show Full Image'),
                              content: Image.network(albums[index]['url']),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('Ok'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
            child: Card(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Image.network(albums[index]['thumbnailUrl']),
                      height: 120,
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Container(
                          color: Colors.white,
                          height: 120,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                  'Photo at albumId: ${albums[index]['id'].toString()}',style: TextStyle(fontSize: 17,fontWeight:FontWeight.bold ),),
                              Text(albums[index]['title']),
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
