import 'package:flutter/material.dart';

import '../../../components/loading_card.dart';
import '../../../model/coin_data.dart';
import '../../../model/web_service.dart';
import 'crypto_asset.dart';
class AllCoins extends StatefulWidget {
  const AllCoins({
    Key? key,
  }) : super(key: key);

  @override
  State<AllCoins> createState() => _AllCoinsState();
}

class _AllCoinsState extends State<AllCoins> {
  bool loading = true;
  List<CoinData> coins = [];

  loadAllcoins() async {
    coins = await WebService().getAllCoins();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    loadAllcoins();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: loading
          ? const Padding(
              padding: EdgeInsets.only(top: 16),
              child: LoadingCard(),
            )
          : Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...List.generate(coins.length, (index) {
                    return Column(
                      children: [
                        CrptoAsset(coinData: coins[index]),
                        const SizedBox(
                          height: 8,
                        )
                      ],
                    );
                  })
                ],
              ),
            ),
    );
  }
}
