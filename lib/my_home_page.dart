import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String id;
String userId;
String title;
String body;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String url = 'https://jsonplaceholder.typicode.com/posts';
  List data;

  // ignore: missing_return
  Future<String> makeRequest() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    setState(() {
      var extractData = jsonDecode(response.body);
      return data = extractData;
    });
  }

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
                  leading: Text(data[index]['id'].toString()),
                  onTap: () {
                    setState(() {
                      id = data[index]['id'].toString();

                      Navigator.of(context).pushNamed(
                        '/secondPage',
                        arguments: id,
                      );
                      print(id);
                    });
                  },
                ),
              ),
            );
          }),
    );
  }
}
