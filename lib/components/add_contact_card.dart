import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class AddContact extends StatelessWidget {
  const AddContact({
    Key? key,
  }) : super(key: key);

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
                  borderRadius: BorderRadius.circular(20), border: Border.all(color: kAccentColor, width: 0.5)),
              child: const Icon(Icons.add, color: Colors.white,)),
          Text("Contact", style: GoogleFonts.poppins(fontSize: 12, color: kAccentColor, fontWeight: FontWeight.w300)),
        ],
      ),
    );
  }
}
