import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter_tts/flutter_tts.dart';

class OCR extends StatefulWidget {
  @override
  _OCRState createState() => _OCRState();
}

class _OCRState extends State<OCR> {
  FlutterTts flutterTts = FlutterTts();
  File pickedImage;
  bool isImageLoaded = false, isText = false;
  var decodedImage;
  var height;
  var width;
  String text;
  Future pickImage() async {
    var tempStore;
    tempStore = await ImagePicker.pickImage(source: ImageSource.gallery);
    decodedImage = await decodeImageFromList(tempStore.readAsBytesSync());
//    print(decodedImage.height);
//    print(decodedImage.width);
    setState(() {
      pickedImage = tempStore;
      isImageLoaded = true;
      height = decodedImage.height;
      width = decodedImage.width;
    });
  }

  Future speak(text) async {
    print(text);
    flutterTts.speak(text);
  }

  Future readText() async {
    text = "";
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(ourImage);
    for (TextBlock block in readText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          text = text + word.text + " ";
        }
      }
    }
    setState(() {
      isText = true;
    });
    speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              isImageLoaded
                  ? Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 1.25,
                        width: MediaQuery.of(context).size.width,
//                      width: width,
//                      height: height,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(pickedImage), fit: BoxFit.fill),
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(height: 10),
              Center(
                child: RaisedButton(
                  child: Text('Read Text'),
                  onPressed: () {
                    readText();
                  },
                ),
              ),
              SizedBox(height: 10),
              isText
                  ? Center(
                      child: Container(
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.all(10),
                          child: Text(text)),
                    )
                  : Container(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_a_photo),
          onPressed: () {
            pickImage();
          },
        ),
      ),
    );
  }
}
