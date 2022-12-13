import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants.dart';
import '../../../model/coin_data.dart';
import '../../../model/database_services.dart';
import '../asset/asset_screen.dart';
import 'crypto_image.dart';

class CrptoAsset extends StatefulWidget {
  const CrptoAsset({
    Key? key,
    required this.coinData,
  }) : super(key: key);
  final CoinData coinData;

  @override
  State<CrptoAsset> createState() => _CrptoAssetState();
}

class _CrptoAssetState extends State<CrptoAsset> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AssetScreen(coinData: widget.coinData);
        }));
      },
      child: Container(
        height: 60,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.black.withAlpha(60),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CryptoImage(
              image: widget.coinData.image,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.coinData.name,
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: kAccentColor,
                      fontWeight: FontWeight.normal),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  widget.coinData.slug,
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: kAccentColor,
                      fontWeight: FontWeight.normal),
                ),
              ],
            )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "\$ ${widget.coinData.price}",
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: kAccentColor,
                      fontWeight: FontWeight.normal),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "${widget.coinData.changeHour.toStringAsPrecision(3)}%",
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: widget.coinData.changeHour.isNegative
                          ? Colors.redAccent
                          : Colors.greenAccent,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
            IconButton(
                onPressed: () {
                  bool isFavorite = widget.coinData.favorite;
                  setState(() {
                    widget.coinData.favorite = !isFavorite;
                    widget.coinData.favorite
                        ? DBService()
                            .addFavoriteAsset(widget.coinData.toMap())
                            .then((value) =>
                                debugPrint(value ? 'removed' : 'not removed'))
                        : DBService()
                            .removeFavoriteAsset(widget.coinData.id)
                            .then((value) =>
                                debugPrint(value ? 'added' : 'not added'));
                  });
                },
                icon: Icon(
                    widget.coinData.favorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_outlined,
                    color: kPrimaryColor))
          ],
        ),
      ),
    );
  }
}
