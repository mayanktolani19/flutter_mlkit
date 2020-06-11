import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
