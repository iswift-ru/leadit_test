import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String url = 'https://jsonplaceholder.typicode.com/posts';
  List data;

  Future<String> makeRequest() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    debugPrint('Привет $url');
//    print(response.body);

    setState(() {
      var extractData = jsonDecode(response.body);
      return data = extractData;
    });
  }

//  @override
//  void initState() {
//    // TODO: implement initState
//    this.makeRequest();
//  }

  @override
  void initState() {
    // TODO: implement initState
    this.makeRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    border:
                        Border(top: BorderSide(color: Colors.blue, width: 2)),
                    color: Colors.amber),
                child: ListTile(
                  title: Text(data[index]['title']),
                  subtitle: Text(data[index]['body']),
                  trailing: Icon(Icons.comment),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                SecondPage(data[index])));
                  },
                ),
              ),
            );
          }),
    );
  }
}

class SecondPage extends StatefulWidget {
  SecondPage(this.data);
  final data;

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  String urlComments =
      'https://jsonplaceholder.typicode.com/comments?postId=1'; //${data['id'].toString()}
  List comments;
  Future<String> makeRequestComments() async {
    var responseComments = await http.get(Uri.encodeFull(urlComments),
        headers: {"Accept": "application/json"});
    debugPrint('Привет 2 $urlComments');
    print(responseComments.body);
    setState(() {
      var extractComments = jsonDecode(responseComments.body);

      return comments = extractComments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments for id ${widget.data['id'].toString()}'),
      ),
      body: ListView.builder(
          itemCount: comments == null ? 0 : comments.length,
          itemBuilder: (BuildContext context, ind) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    border:
                        Border(top: BorderSide(color: Colors.blue, width: 2)),
                    color: Colors.amber),
                child: ListTile(
                  title: Text(comments[ind]['name']),
                  subtitle: Text(comments[ind]['body']),
                ),
              ),
            );
          }),
    );
  }
}
