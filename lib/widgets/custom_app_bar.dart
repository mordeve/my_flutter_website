import 'package:esmabatu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // dynamic text size
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.only(
            top: 48.0,
            left: 32.0,
            right: 32.0,
            bottom: 12.0,
          ),
          child: Text(
            appName,
            style: GoogleFonts.parisienne(
              fontSize: 150,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
