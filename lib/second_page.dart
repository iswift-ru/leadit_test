import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'my_home_page.dart';

class SecondPage extends StatefulWidget {
  static const routeName = '/secondPage';

  final String id;
  SecondPage({
    Key key,
    this.id,
  }) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  void initState() {
    // TODO: implement initState
    this.makeRequestComments();
    super.initState();
  }

  List comments;
  // ignore: missing_return
  Future<String> makeRequestComments() async {
    String urlComments =
        'https://jsonplaceholder.typicode.com/comments?postId=$id';
    print("Привет 2 $urlComments");
    print('ID $id');
    var responseComments = await http.get(Uri.encodeFull(urlComments),
        headers: {"Accept": "application/json"});
    if (responseComments.statusCode == 200) {
      var extractComments = jsonDecode(responseComments.body);
      setState(() {
        return comments = extractComments;
      });
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments for posts $id'),
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
                  trailing: Text(comments[ind]['email']),
                ),
              ),
            );
          }),
    );
  }
}
