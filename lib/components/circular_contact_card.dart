import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class CircularContactCard extends StatelessWidget {
  const CircularContactCard({Key? key, required this.name, required this.image}) : super(key: key);
  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            margin: const EdgeInsets.only(bottom: 4),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                boxShadow: const [
                  // BoxShadow(color: kAccentColor, offset: Offset(2, 2), spreadRadius: 4, blurRadius: 4),
                  BoxShadow(color: Colors.black, offset: Offset(0, 1), spreadRadius: 1, blurRadius: 8)
                ],
                image: DecorationImage(image: AssetImage(image)),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: kAccentColor, width: 0.5)),
          ),
          Text(name, style: GoogleFonts.poppins(fontSize: 12, color: kAccentColor, fontWeight: FontWeight.w300)),
        ],
      ),
    );
  }
}
