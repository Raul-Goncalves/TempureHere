import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class appFonts {
  appFonts._();

  static TextStyle normalText({Color color = Colors.white}) {
    return GoogleFonts.signika(
      fontWeight: FontWeight.normal,
      fontSize: 16,
      color: color,
    );
  }

  static TextStyle titleTemp({Color color = Colors.white}) {
    return GoogleFonts.signika(
      fontSize: 54,
      color: color,
    );
  }

  static TextStyle subText({Color color = Colors.white}) {
    return GoogleFonts.signika(
      fontWeight: FontWeight.normal,
      fontSize: 16,
      color: color,
    );
  }

  static TextStyle custom({Color color = Colors.white}) {
    return GoogleFonts.signika(
      fontWeight: FontWeight.normal,
      fontSize: 25,
      color: color,
    );
  }

}