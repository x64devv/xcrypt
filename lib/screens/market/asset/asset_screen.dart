import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../model/coin_data.dart';
import 'components/body.dart';

class AssetScreen extends StatelessWidget {
  const AssetScreen({super.key, required this.coinData});
  final CoinData coinData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(child: Body(coinData: coinData,)),
    );
  }
}