import 'package:flutter/material.dart';

import '../../../constants.dart';

class CryptoImage extends StatelessWidget {
  const CryptoImage({
    Key? key,
    required this.image,
  }) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(image)),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: kAccentColor)),
    );
  }
}
