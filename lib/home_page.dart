import 'package:flutter/material.dart';
import 'ocr.dart';
import 'face_recognition.dart';
import 'genderify.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('OCR'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => OCR()));
              },
            ),
            RaisedButton(
              child: Text('Face Recognition'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => FaceRecognition()));
              },
            ),
            RaisedButton(
              child: Text('Genderify'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Genderify()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
