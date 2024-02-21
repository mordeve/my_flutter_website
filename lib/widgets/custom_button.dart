import 'package:esmabatu/utils/constants.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.btnText,
    required this.onPressed,
  });

  final String btnText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ElevatedButton.styleFrom(
        minimumSize: kButtonSize,
        backgroundColor: const Color.fromARGB(255, 223, 240, 252),
        // backgroundColor: Color.fromARGB(255, 229, 216, 180),
      ),
      child: Text(
        btnText,
        style: GoogleFonts.quicksand(
          fontSize: kButtonTextSize,
          color: Colors.blueGrey[800],
        ),
      ),
    );
  }
}
