import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'dart:io';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ImageLabeler extends StatefulWidget {
  @override
  _ImageLabelerState createState() => _ImageLabelerState();
}

class _ImageLabelerState extends State<ImageLabeler> {
  FlutterTts flutterTts = FlutterTts();
  bool _gallery = true, selected = false;
  var labelText, labelConfidence;
  File pickedImage;
  String speakText;

  Future speak(String hi) async {
    await flutterTts.setSpeechRate(0.8);
    flutterTts.speak(hi);
  }

  Future pickImage() async {
    labelText = [];
    labelConfidence = [];
    speakText = "The labels are,   ";
    var image;
    if (_gallery)
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    else
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image == null) return;
    FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(image);
    var labeler = FirebaseVision.instance.imageLabeler();
    final List<ImageLabel> labels = await labeler.processImage(visionImage);
    for (ImageLabel label in labels) {
      if (label.confidence > 0.7) {
        speakText = speakText + label.text + ",    ";
      }
      labelText.add(label.text);
      labelConfidence.add(label.confidence);
    }
    speak(speakText);
    setState(() {
      selected = true;
      pickedImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Image Labeler'),
        ),
        body: _buildBody(pickedImage),
        floatingActionButton: _getFAB(),
      ),
    );
  }

  Widget _buildBody(File _file) {
    return new Container(
      child: new Column(
        children: <Widget>[displaySelectedFile(_file), _buildList()],
      ),
    );
  }

  Widget displaySelectedFile(File file) {
    return new SizedBox(
      height: MediaQuery.of(context).size.height / 1.75,
      child: file == null
          ? new Text('Sorry nothing selected!!')
          : new Image.file(file),
    );
  }

  Widget _buildList() {
    if (!selected) {
      return Text('Empty', textAlign: TextAlign.center);
    }
    return Expanded(
      child: Container(
        child: ListView.builder(
            padding: const EdgeInsets.all(1.0),
            itemCount: labelText.length,
            itemBuilder: (context, i) {
              if (labelConfidence[i] > 0.7) {
                //speak();
                return _buildRow(labelText[i],
                    (labelConfidence[i] * 100).toStringAsFixed(0));
              }
              return SizedBox(height: 0.0, width: 0.0);
            }),
      ),
    );
  }

  Widget _buildRow(String label, String confidence) {
    return new ListTile(
      title: new Text(
        "\nLabel: $label \nConfidence: $confidence% ",
      ),
      dense: true,
    );
  }

  Widget _getFAB() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22),
      backgroundColor: Colors.blueAccent,
      visible: true,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
            child: Icon(Icons.image),
            backgroundColor: Colors.blue,
            onTap: () {
              setState(() {
                _gallery = true;
              });
              pickImage();
            },
            label: 'Pick from Gallery',
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16.0),
            labelBackgroundColor: Colors.blue),
        SpeedDialChild(
            child: Icon(Icons.add_a_photo),
            backgroundColor: Colors.blue,
            onTap: () {
              setState(() {
                _gallery = false;
                pickImage();
              });
            },
            label: 'Open Camera',
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16.0),
            labelBackgroundColor: Colors.blue)
      ],
    );
  }
}
