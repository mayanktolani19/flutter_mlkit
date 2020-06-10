import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'dart:io';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class FaceRecognition extends StatefulWidget {
  @override
  _FaceRecognitionState createState() => _FaceRecognitionState();
}

class _FaceRecognitionState extends State<FaceRecognition> {
  ui.Image image;
  List<Rect> rect = new List<Rect>();
  bool selected = false;
  bool gallery = true;

  Future<ui.Image> loadImage(File image) async {
    var img = await image.readAsBytes();
    return await decodeImageFromList(img);
  }

  Future getImage() async {
    var image;
    if (gallery)
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    else
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      rect = List<Rect>();
    });
    if (image == null) return;
    var visionImage = FirebaseVisionImage.fromFile(image);

    var faceDetector = FirebaseVision.instance.faceDetector();

    List<Face> faces = await faceDetector.processImage(visionImage);

    for (Face f in faces) {
      rect.add(f.boundingBox);
    }

    loadImage(image).then((img) {
      setState(() {
        this.image = img;
        selected = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Color.fromRGBO(0, 15, 200, 10),
            Color.fromRGBO(120, 20, 150, 10)
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: selected
            ? Center(
                child: Container(
                  child: FittedBox(
                    child: SizedBox(
                      width: image.width.toDouble(),
                      height: image.height.toDouble(),
                      child: CustomPaint(
                        painter: Painter(rect: rect, image: image),
                      ),
                    ),
                  ),
                ),
              )
            : Container(),
        floatingActionButton: _getFAB(),
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
            getImage();
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
              getImage();
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

class Painter extends CustomPainter {
  List<Rect> rect;
  ui.Image image;

  Painter({@required this.rect, @required this.image});

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    if (image != null) {
      canvas.drawImage(image, Offset.zero, Paint());
    }

    for (Rect rect in this.rect) {
      canvas.drawRect(
        rect,
        Paint()
          ..color = Colors.amberAccent
          ..strokeWidth = 5.0
          ..style = PaintingStyle.stroke,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
