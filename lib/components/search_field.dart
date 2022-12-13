import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';


class SearchField extends StatelessWidget {
  SearchField({
    Key? key,
    required this.hint,
    required this.onPress,
  }) : super(key: key);
  final String hint;
  final Function(String) onPress;
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(60),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextFormField(
          onChanged: (value) {
            searchQuery = value;
          },
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: kAccentColor,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.poppins(
              fontSize: 12,
              color: kAccentColor,
            ),
            border: InputBorder.none,
            prefixIcon: IconButton(
                icon: const Icon(
                  Icons.search_rounded,
                  color: kAccentColor,
                  size: 18,
                ),
                onPressed: () {
                  onPress(searchQuery);
                }),
          )),
    );
  }
}
