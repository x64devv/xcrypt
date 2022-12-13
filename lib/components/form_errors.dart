import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormErrors extends StatelessWidget {
  const FormErrors({Key? key, required this.errors}) : super(key: key);
  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(
            errors.length,
            (index) => Row(
                  children: [
                    const Icon(
                      Icons.cancel_outlined,
                      color: Colors.red,
                    ),
                    Text(
                      " ${errors[index]}",
                      style: GoogleFonts.poppins(fontSize: 12, color: Colors.red, fontWeight: FontWeight.bold),
                    )
                  ],
                )),
      ],
    );
  }
}
