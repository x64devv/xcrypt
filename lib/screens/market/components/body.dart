import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../components/search_field.dart';
import '../../../constants.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../model/coin_data.dart';
import '../../../model/database_services.dart';
import 'all_coins.dart';
import 'favorite_coin.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      padding: const EdgeInsets.only(top: 28, left: 8, right: 8),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [kPrimaryColor, kPrimaryGradientColor2],
      )),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchField(hint: "Search asset...", onPress: (searchQuery) {}),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Favorites",
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: kAccentColor,
                      fontWeight: FontWeight.bold),
                ),
                const Icon(
                  Icons.replay_rounded,
                  color: kAccentColor,
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            FutureBuilder(
              initialData: const <CoinData>[],
              future: DBService().getFavoriteAssets(),
              builder: (context, AsyncSnapshot<List<CoinData>> snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return Container(
                    height: size.height * 0.45,
                    child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return FavoriteCoin(size: size, coinData:  snapshot.data![index]);
                        }),
                  );
                }
                return Text(
                  "When you have favorites available they will appear here!",
                  style: GoogleFonts.poppins(
                    color: kAccentColor,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "All",
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: kAccentColor,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            AllCoins()
          ],
        ),
      ),
    );
  }
}


