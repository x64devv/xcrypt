import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:web3dart/credentials.dart';
import 'package:xcrypt/model/web3_services.dart';
import 'package:xcrypt/screens/home/components/wallet_balance.dart';

import '../../../constants.dart';

class WalletCard extends StatefulWidget {
  const WalletCard({
    Key? key,
    required this.size,
    required this.wallet,
  }) : super(key: key);

  final Map<String, dynamic> wallet;
  final Size size;

  @override
  State<WalletCard> createState() => _WalletCardState();
}

class _WalletCardState extends State<WalletCard> {
  late String name;
  late Wallet wallet;
  String dollarBalance = '\$ --.--';
  String ethBalance = 'ETH --.--';

  fetchBalance() {
    Web3Services().getBalance(wallet.privateKey).then((bal) {
      setState(() {
        ethBalance = 'ETH $bal';
      });
    });
  }

  @override
  void initState() {
    name = widget.wallet['name'];
    wallet = widget.wallet['wallet'];
    fetchBalance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      width: widget.size.width * 0.95,
      height: widget.size.height * 0.3,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [kPrimaryColor, kPrimaryGradientColor2],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight),
        boxShadow: const [
          // BoxShadow(color: kAccentColor, offset: Offset(2, 2), spreadRadius: 4, blurRadius: 4),
          BoxShadow(
              color: Colors.black,
              offset: Offset(0, 1),
              spreadRadius: 1,
              blurRadius: 8)
        ],
        borderRadius: BorderRadius.circular(16),
        // border: Border.all(color: kAccentColor, width: 0.3)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(widget.wallet['name'],
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: kAccentColor,
                    fontWeight: FontWeight.bold)),
            const Icon(
              Icons.wallet,
              color: kAccentColor,
            )
          ]),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              WalletBalance(balance: dollarBalance),
              const SizedBox(
                width: 16,
              ),
              WalletBalance(balance: ethBalance),
            ],
          ),
          const Spacer(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
              flex: 2,
              child: Text(wallet.privateKey.address.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: kAccentColor,
                      fontWeight: FontWeight.w300)),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  Clipboard.setData(
                    ClipboardData(
                      text: wallet.privateKey.address.toString(),
                    ),
                  );
                },
                child: const Icon(
                  Icons.copy_sharp,
                  color: kAccentColor,
                ),
              ),
            )
          ]),
          const Spacer(),
        ],
      ),
    );
  }
}
