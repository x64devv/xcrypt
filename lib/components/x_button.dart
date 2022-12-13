import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class XButton extends StatelessWidget {
  const XButton({
    Key? key,
    required this.text,
    required this.color,
    required this.textColor,
    required this.onTap,
  }) : super(key: key);
  final Color color;
  final Color textColor;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(2),
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: kAccentColor),
          color: color,
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w800, color: textColor),
          ),
        ),
      ),
    );
  }
}
