import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'texts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class OCR extends StatefulWidget {
  @override
  _OCRState createState() => _OCRState();
}

class _OCRState extends State<OCR> {
  FlutterTts flutterTts = FlutterTts();
  File pickedImage;
  bool isImageLoaded = false,
      isText = false,
      gallery = true,
      showSpinner = false;
  var decodedImage, height, width;
  var color1 = Color.fromRGBO(0, 15, 200, 10);
  var color2 = Color.fromRGBO(120, 20, 150, 10);
  String text;
  Future pickImage() async {
    setState(() {
      showSpinner = true;
    });
    var tempStore;
    if (gallery)
      tempStore = await ImagePicker.pickImage(source: ImageSource.gallery);
    else
      tempStore = await ImagePicker.pickImage(source: ImageSource.camera);
    if (tempStore == null) {
      setState(() {
        showSpinner = false;
      });
      return;
    }
    setState(() {
      color1 = Color.fromRGBO(0, 15, 0, 10);
      color2 = Color.fromRGBO(0, 10, 45, 10);
    });
    decodedImage = await decodeImageFromList(tempStore.readAsBytesSync());
    setState(() {
      pickedImage = tempStore;
      isImageLoaded = true;
      showSpinner = false;
      height = decodedImage.height;
      width = decodedImage.width;
    });
  }

  Future speak(text) async {
    await flutterTts.setSpeechRate(0.9);
    flutterTts.speak(text + ",");
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
          speak(text);
        }
      }
    }
    setState(() {
      isText = true;
    });
    //speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [color1, color2])),
        child: Scaffold(
            appBar: AppBar(
              title: Texts('OCR', 18),
              backgroundColor: Colors.transparent,
            ),
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  isImageLoaded
                      ? Center(
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: (decodedImage.height.toDouble() / 1.25 >
                                        MediaQuery.of(context).size.height)
                                    ? MediaQuery.of(context).size.height / 1.25
                                    : decodedImage.height.toDouble(),
                                width: (decodedImage.width.toDouble() >
                                        MediaQuery.of(context).size.width)
                                    ? MediaQuery.of(context).size.width
                                    : decodedImage.width.toDouble(),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: FileImage(pickedImage),
                                  ),
                                ),
                              ),
                              Center(
                                child: Container(
                                  margin: EdgeInsets.only(top: 10),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(
                                      color: Colors.indigoAccent,
                                    ),
                                  ),
                                  child: MaterialButton(
                                    child: Texts('Read Text', 15),
                                    onPressed: () {
                                      readText();
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      : Column(
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.only(
                                    top: 100, left: 25, right: 25, bottom: 40),
                                padding: EdgeInsets.all(10),
                                child: Texts(
                                    'Oops.....No text to recognize, please select an image.',
                                    25)),
                            Divider(color: Colors.grey),
                          ],
                        ),
                  isText
                      ? Center(
                          child: Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.all(10),
                              child: Texts(text, 20)),
                        )
                      : Container(),
                ],
              ),
            ),
            floatingActionButton: _getFAB()),
      ),
    );
  }

  Widget _getFAB() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22),
      backgroundColor: Color.fromRGBO(35, 20, 170, 5),
      visible: true,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
          child: Icon(Icons.image),
          backgroundColor: Color.fromRGBO(120, 20, 150, 10),
          onTap: () {
            setState(() {
              gallery = true;
            });
            pickImage();
          },
          label: 'Pick from Gallery',
          labelStyle: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.white, fontSize: 16.0),
          labelBackgroundColor: Color.fromRGBO(120, 20, 150, 10),
        ),
        SpeedDialChild(
          child: Icon(Icons.add_a_photo),
          backgroundColor: Color.fromRGBO(120, 20, 150, 10),
          onTap: () {
            setState(() {
              gallery = false;
              pickImage();
            });
          },
          label: 'Open Camera',
          labelStyle: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.white, fontSize: 16.0),
          labelBackgroundColor: Color.fromRGBO(120, 20, 150, 10),
        )
      ],
    );
  }
}
