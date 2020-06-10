import 'package:flutter/material.dart';
import 'ocr.dart';
import 'face_recognition.dart';
import 'genderify.dart';
import 'object_detection.dart';
import 'image_labelling.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                          child: Texts(
                              'Welcome To Machine Learning Kit in Flutter',
                              30)),
                      Icon(Icons.touch_app, size: 50, color: Colors.white)
                    ],
                  )),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.all(10),
                  //padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    border: Border.all(
                      color: Colors.indigoAccent,
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => OCR()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: Icon(Icons.text_fields,
                                color: Colors.white, size: 25)),
                        Expanded(
                            flex: 5,
                            child: Texts(
                                'Optical Character Recognition (OCR)', 20)),
                        Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.navigate_next,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.all(10),
                  //padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    border: Border.all(
                      color: Colors.indigoAccent,
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  FaceRecognition()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: Icon(Icons.tag_faces,
                                color: Colors.white, size: 25)),
                        Expanded(flex: 5, child: Texts('Face Recognition', 20)),
                        Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.navigate_next,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.all(10),
                  //padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    border: Border.all(
                      color: Colors.indigoAccent,
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ImageLabeler()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: Icon(Icons.burst_mode,
                                color: Colors.white, size: 25)),
                        Expanded(flex: 5, child: Texts('Image Labelling', 20)),
                        Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.navigate_next,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.all(10),
                  //padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    border: Border.all(
                      color: Colors.indigoAccent,
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ObjectDetector()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child:
                                Icon(Icons.adb, color: Colors.white, size: 25)),
                        Expanded(flex: 5, child: Texts('Object Detection', 20)),
                        Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.navigate_next,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.all(10),
                  //padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    border: Border.all(
                      color: Colors.indigoAccent,
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Genderify()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: Icon(Icons.supervised_user_circle,
                                color: Colors.white, size: 25)),
                        Expanded(flex: 5, child: Texts('Genderify', 20)),
                        Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.navigate_next,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Texts extends StatelessWidget {
  final String text;
  final double fontSize;
  Texts(this.text, this.fontSize);

  @override
  Widget build(BuildContext context) {
    return Text(
      '$text',
      textAlign: TextAlign.center,
      style: GoogleFonts.adamina(
        //fontWeight: FontWeight.bold,
        textStyle: TextStyle(
          color: Colors.white,
          letterSpacing: .5,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
