import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'texts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Genderify extends StatefulWidget {
  @override
  _GenderifyState createState() => _GenderifyState();
}

class _GenderifyState extends State<Genderify> {
  String name;
  Map<String, dynamic> result = {};
  bool fetched = false, showSpinner = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void fetchData() async {
    setState(() {
      showSpinner = true;
    });
    http.Response response;
    if (name != null && name.length > 0) {
      response =
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
    } else {
      setState(() {
        fetched = false;
      });
    }
    setState(() {
      showSpinner = false;
    });
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
                colors: [
              Color.fromRGBO(0, 15, 200, 10),
              Color.fromRGBO(120, 20, 150, 10)
            ])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Texts('Genderify', 18),
            backgroundColor: Colors.transparent,
          ),
          body: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(35))),
                  margin: EdgeInsets.all(15),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.blue),
                        labelText: "Enter Name",
                        fillColor: Colors.white,
                        prefixIcon: Icon(
                          Icons.tag_faces,
                          color: Colors.blue,
                        ),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.blue, width: 0.0),
                            borderRadius: BorderRadius.all(Radius.circular(35)))
                        //fillColor: Colors.green
                        ),
                    validator: (val) {
                      if (val.length == 0) {
                        return "Email cannot be empty";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (val) {
                      name = val;
                    },
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 10, bottom: 25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      color: Colors.indigoAccent,
                    ),
                  ),
                  child: MaterialButton(
                    child: Texts('Predict', 15),
                    onPressed: () {
                      fetchData();
                    },
                  ),
                ),
              ),
              (fetched)
                  ? (name.length > 0)
                      ? Container(
                          margin: EdgeInsets.all(25),
                          child: Texts(
                              name +
                                  " is most likely to be a " +
                                  result["Gender"] +
                                  " Name.",
                              20))
                      : Container(
                          margin: EdgeInsets.all(25),
                          child: Texts("Please provide a Name.", 20))
                  : Container(
                      margin: EdgeInsets.all(25),
                      child: Texts("Please provide a Name.", 20))
            ],
          ),
        ),
      ),
    );
  }
}
