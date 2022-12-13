import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants.dart';
import '../../../model/coin_data.dart';
import '../asset/asset_screen.dart';
import 'asset_chart.dart';
import 'crypto_image.dart';

class FavoriteCoin extends StatefulWidget {
  const FavoriteCoin({
    Key? key,
    required this.size,
    required this.coinData,
  }) : super(key: key);

  final Size size;
  final CoinData coinData;

  @override
  State<FavoriteCoin> createState() => _FavoriteCoinState();
}

class _FavoriteCoinState extends State<FavoriteCoin> {
  loadQuote() async {
    await widget.coinData.getQuoute();
  }

  @override
  Widget build(BuildContext context) {
    loadQuote();
    return Container(
      width: widget.size.width * 0.45,
      height: widget.size.height * 0.5,
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(60),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return AssetScreen(coinData: widget.coinData);
                        }));
                      },
                      icon: const Icon(
                        Icons.chevron_right_rounded,
                        color: kAccentColor,
                      )),
                  Text(
                    widget.coinData.name,
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: kAccentColor,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              Text(
                "${widget.coinData.changeHour}%",
                style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          FutureBuilder(
              initialData: const <num>[],
              future: widget.coinData.loadH1Data(),
              builder: (context, AsyncSnapshot<List<num>> snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  List<FlSpot> spotData = [];
                  double x = 0;
                  for (var y in snapshot.data!) {
                    spotData.add(FlSpot(x, double.parse(y.toString())));
                    x++;
                  }
                  return AssetChart(data: spotData);
                }
                return const Expanded(
                  child: Center(
                    child: Icon(
                      Icons.bar_chart_rounded,
                      color: kAccentColor,
                    ),
                  ),
                );
              }),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              CryptoImage(
                image: widget.coinData.image,
              ),
              const Expanded(
                child: SizedBox(
                  width: 2,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.coinData.slug,
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: kAccentColor,
                        fontWeight: FontWeight.normal),
                  ),
                  Text(
                    "\$ ${widget.coinData.changeHour}",
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
