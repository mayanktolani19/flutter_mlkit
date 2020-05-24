import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Genderify extends StatefulWidget {
  @override
  _GenderifyState createState() => _GenderifyState();
}

class _GenderifyState extends State<Genderify> {
  String name;
  Map<String, dynamic> result = {};
  bool fetched = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void fetchData() async {
    http.Response response =
        await http.get('https://genderify.herokuapp.com/genderapi/$name');

    if (response.statusCode == 200) {
      String data = response.body;
      result = jsonDecode(data);
      setState(() {
        fetched = true;
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Genderify')),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                child: TextField(
                  decoration: InputDecoration(hintText: 'Enter name'),
                  onChanged: (value) {
                    name = value;
                  },
                ),
              ),
            ),
            RaisedButton(
              child: Text('Predict'),
              onPressed: () {
                fetchData();
              },
            ),
            fetched
                ? Container(child: Text(name + " is " + result["Gender"]))
                : Container(),
          ],
        ),
      ),
    );
  }
}
