import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants.dart';


class WalletBalance extends StatelessWidget {
  const WalletBalance({
    Key? key,
    required this.balance,
  }) : super(key: key);
  final String balance;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Balance",
            style: GoogleFonts.poppins(
                fontSize: 12,
                color: kAccentColor,
                fontWeight: FontWeight.w300)),
        const SizedBox(
          height: 4,
        ),
        Text(balance,
            style: GoogleFonts.poppins(
                fontSize: 20,
                color: kAccentColor,
                fontWeight: FontWeight.w700)),
      ],
    );
  }
}
