import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants.dart';
import '../../../../model/coin_data.dart';
import '../../components/crypto_image.dart';
import 'asset_chart_area.dart';
import 'asset_info.dart';

class Body extends StatelessWidget {
  const Body({super.key, required this.coinData});
  final CoinData coinData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.chevron_left_rounded,
                  color: kAccentColor,
                ),
              ),
              CryptoImage(image: coinData.image),
              const SizedBox(
                width: 8,
              ),
              Text(
                coinData.name,
                style: GoogleFonts.poppins(color: kAccentColor, fontSize: 16),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: Text(
            "Asset Info",
            style: GoogleFonts.poppins(
                color: kAccentColor, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        AssetInfo(coinData: coinData),
        AssetChartArea(coinData: coinData)
      ],
    );
  }
}
