import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class LoadingCard extends StatelessWidget {
  const LoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          const CircularProgressIndicator(
            color: kAccentColor,
          ),
          const SizedBox(height: 8,),
          Text("Loading Please wait!", style: GoogleFonts.poppins(color: kAccentColor, fontSize: 16),),
        ],
      ),
    );
  }
}