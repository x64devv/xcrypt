import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants.dart';
import '../../../../model/coin_data.dart';

class AssetInfo extends StatefulWidget {
  AssetInfo({super.key, required this.coinData});
  CoinData coinData;

  @override
  State<AssetInfo> createState() => _AssetInfoState();
}

class _AssetInfoState extends State<AssetInfo> {
  fetchQuote() async {
    widget.coinData.getQuoute().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    fetchQuote();
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient:const LinearGradient(colors: [kPrimaryGradientColor1, kPrimaryGradientColor2]),
        boxShadow:const [BoxShadow(color: Colors.black, offset: Offset(1,1), spreadRadius: 1, blurRadius: 8)]
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Price: \$${widget.coinData.price}",
              style: GoogleFonts.poppins(
                color: kAccentColor,
                fontSize: 12,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                      text: "Hour Change: ",
                      style:
                          GoogleFonts.poppins(color: kAccentColor, fontSize: 12),
                      children: [
                        TextSpan(
                            text: "${widget.coinData.changeHour.toStringAsPrecision(3)}%",
                            style: GoogleFonts.poppins(
                                color: widget.coinData.changeHour.isNegative
                                    ? Colors.redAccent
                                    : Colors.greenAccent))
                      ]),
                ),
                RichText(
                  text: TextSpan(
                      text: "Change Day: ",
                      style:
                          GoogleFonts.poppins(color: kAccentColor, fontSize: 12),
                      children: [
                        TextSpan(
                            text: "${widget.coinData.changeDay.toStringAsPrecision(3)}%",
                            style: GoogleFonts.poppins(
                                color: widget.coinData.changeDay.isNegative
                                    ? Colors.redAccent
                                    : Colors.greenAccent))
                      ]),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
