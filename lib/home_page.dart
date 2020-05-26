import 'package:flutter/material.dart';
import 'ocr.dart';
import 'face_recognition.dart';
import 'genderify.dart';
import 'object_detection.dart';
import 'image_labelling.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 150.0),
          child: Column(
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
                          builder: (BuildContext context) =>
                              FaceRecognition()));
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
              RaisedButton(
                child: Text('Object Detection'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => ObjectDetector()));
                },
              ),
              RaisedButton(
                child: Text('Image Labelling'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => ImageLabeler()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
