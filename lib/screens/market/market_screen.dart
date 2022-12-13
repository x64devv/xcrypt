import 'package:flutter/material.dart';

import 'components/body.dart';

class MarketScreen extends StatelessWidget {
  const MarketScreen({super.key});
  static String routeName = "/market";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
