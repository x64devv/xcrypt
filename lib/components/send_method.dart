import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class SendMethod extends StatelessWidget {
  const SendMethod({
    Key? key,
    required this.text,
    required this.width,
    required this.icon,
    required this.onTap,
  }) : super(key: key);
  final String text;
  final double width;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
            color: Colors.black.withAlpha(60),
            borderRadius: BorderRadius.circular(12),
            // boxShadow: const [
            //   // BoxShadow(color: kAccentColor, offset: Offset(2, 2), spreadRadius: 4, blurRadius: 4),
            //   BoxShadow(color: Colors.black, offset: Offset(0, 1), spreadRadius: 1, blurRadius: 8)
            // ]
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: kAccentColor),
            const SizedBox(
              height: 4,
            ),
            Text(text, style: GoogleFonts.poppins(fontSize: 12, color: kAccentColor, fontWeight: FontWeight.w300)),
          ],
        ),
      ),
    );
  }
}
