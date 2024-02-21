import 'package:esmabatu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FamilyCard extends StatelessWidget {
  const FamilyCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 64.0),
        child: Container(
            width: 550,
            height: 120,
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(10),
            //   boxShadow: [
            //     BoxShadow(
            //       color: Colors.grey.withOpacity(0.3),
            //       blurRadius: 20.0,
            //       spreadRadius: 4.0,
            //     ),
            //   ],
            // ),
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
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(width: 4.0),
                  familyContent(gelinMom, gelinDad, gelinLastname),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: VerticalDivider(
                      color: Colors.black.withOpacity(0.2),
                      thickness: 1.0,
                      width: 32.0,
                    ),
                  ),
                  familyContent(damatMom, damatDad, damatLastname),
                  const SizedBox(width: 4.0),
                ],
              ),
            )),
      ),
    );
  }

  Widget familyContent(String momName, String dadName, String lastname) {
    const kFamilyFontSize = 20.0;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(
              momName,
              style: GoogleFonts.quicksand(
                fontSize: kFamilyFontSize,
                fontWeight: FontWeight.w500,
                color: Colors.blueGrey[600],
              ),
            ),
            const SizedBox(width: 4.0),
            Text(
              "-",
              style: GoogleFonts.quicksand(
                fontSize: kFamilyFontSize,
                fontWeight: FontWeight.w500,
                color: Colors.blueGrey[600],
              ),
            ),
            const SizedBox(width: 4.0),
            Text(
              dadName,
              style: GoogleFonts.quicksand(
                fontSize: kFamilyFontSize,
                fontWeight: FontWeight.w500,
                color: Colors.blueGrey[600],
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Text(
          lastname,
          style: GoogleFonts.quicksand(
            fontSize: kFamilyFontSize,
            fontWeight: FontWeight.w500,
            color: Colors.blueGrey[600],
          ),
        ),
      ],
    );
  }
}
