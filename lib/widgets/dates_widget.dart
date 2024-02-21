import 'package:esmabatu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DatesWidget extends StatelessWidget {
  const DatesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double datesFontSize = 24.0;
    var screenSize = MediaQuery.of(context).size.width;

    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 64.0),
        child: Container(
          width: screenSize < 800 ? 600 : screenSize * 0.6,
          padding: const EdgeInsets.symmetric(
            vertical: 32.0,
            horizontal: 20.0,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.blueGrey.shade200,
                blurRadius: 30.0,
                spreadRadius: 2.0,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Kına:   ",
                      style: GoogleFonts.quicksand(
                        fontSize: datesFontSize,
                        color: Colors.blueGrey[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: kinaText,
                      style: GoogleFonts.quicksand(
                        fontSize: datesFontSize,
                        color: Colors.blueGrey[600],
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Düğün: ",
                      style: GoogleFonts.quicksand(
                        fontSize: datesFontSize,
                        color: Colors.blueGrey[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: dugunText,
                      style: GoogleFonts.quicksand(
                        fontSize: datesFontSize,
                        color: Colors.blueGrey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
