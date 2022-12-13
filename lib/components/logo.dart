import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import 'gradient_text.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 30,
          width: 30,
          margin: const EdgeInsets.only(right: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: kAccentColor,
          ),
          child: Center(
            child: GradientText(
              gradient: LinearGradient(
                  colors: [kPrimaryColor, kPrimaryDarkColor], begin: Alignment.center, end: Alignment.centerRight),
              text: "X",
              style: GoogleFonts.poppins(fontSize: 18, color: kPrimaryColor, fontWeight: FontWeight.w900),
            ),
          ),
        ),
        Text(
          "Wallet",
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w900, color: kAccentColor),
        ),
      ],
    );
  }
}
