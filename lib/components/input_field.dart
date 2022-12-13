import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.keyBoardType,
    required this.hintText,
    required this.prefixIcon,
    required this.validator,
    required this.onChanged,
  }) : super(key: key);
  final TextInputType keyBoardType;
  final String hintText;
  final IconData prefixIcon;
  final FormFieldValidator validator;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: kAccentColor),
      child: TextFormField(
        validator: validator,
        onChanged: onChanged,
        obscureText: keyBoardType == TextInputType.visiblePassword,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: InputBorder.none,
          hintText: hintText,
          prefixIcon: Icon(
            prefixIcon,
            color: kPrimaryColor,
          ),
          hintStyle: GoogleFonts.poppins(fontSize: 18, color: kPrimaryColor.withOpacity(0.8)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        ),
      ),
    );
  }
}
