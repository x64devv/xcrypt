import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3dart/credentials.dart';
import 'package:xcrypt/components/input_field.dart';
import 'package:xcrypt/components/x_button.dart';
import 'package:xcrypt/screens/home/components/wallet_card.dart';

import '../../../components/add_contact_card.dart';
import '../../../components/circular_contact_card.dart';
import '../../../components/profile_image.dart';
import '../../../components/send_method.dart';
import '../../../constants.dart';
import '../../../model/database_services.dart';
import '../../../model/web3_services.dart';
import 'no_wallet_card.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Map<String, String>> contacts = [
    {"name": "Nigel", "image": "avatar_1.jpeg"},
    {"name": "Cecil", "image": "avatar_2.jpeg"},
    {"name": "Jack", "image": "avatar_3.jpeg"},
    {"name": "Zayne_Shit", "image": "avatar_4.jpeg"},
  ];

  User? user = FirebaseAuth.instance.currentUser;
  int indicatorLenght = 0;
  int currentIndex = 0;
  late SharedPreferences prefs;

  @override
  void initState() {
    SharedPreferences.getInstance().then((pref) {
      prefs = pref;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      padding: const EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [kPrimaryColor, kPrimaryGradientColor2],
      )),
      child: Padding(
        padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const ProfileImage(image: "assets/images/avatar_3.jpeg"),
                  RichText(
                    text: TextSpan(
                      text: "Hello, ",
                      style: GoogleFonts.poppins(
                          fontSize: 12, color: kAccentColor.withOpacity(0.7)),
                      children: [
                        TextSpan(
                            text: user!.email!
                                .substring(0, user!.email!.indexOf('@')),
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: kAccentColor,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  const Expanded(
                    child: SizedBox(
                      width: 16,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.replay_outlined,
                      color: kAccentColor,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
              Container(
                height: size.height * 0.38,
                child: FutureBuilder(
                  future: fetchWallets(),
                  builder: (context,
                      AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isEmpty) {
                        return NoWalletsCard(size: size);
                      }
                      List<Map<String, dynamic>> wallets = snapshot.data!;
                      if (snapshot.data!.length == 1 &&
                          snapshot.data![0]['failed']) {
                        return Center(
                          child: Text(
                            "Permission to read files denied!",
                            style: GoogleFonts.poppins(color: kAccentColor),
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          prefs.setString(
                              'currentWallet', wallets[index]['name']);
                          return Column(
                            children: [
                              WalletCard(
                                size: size,
                                wallet: wallets[index],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Container(
                                height: 20,
                                width: size.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ...List.generate(
                                        snapshot.data!.length,
                                        (cardIndex) => Container(
                                              decoration: BoxDecoration(
                                                color: kAccentColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        index == cardIndex
                                                            ? 8
                                                            : 4),
                                              ),
                                              margin: const EdgeInsets.all(4),
                                              height:
                                                  index == cardIndex ? 16 : 8,
                                              width:
                                                  index == cardIndex ? 16 : 8,
                                            ))
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("Oooops: ${snapshot.error.toString()}", style: GoogleFonts.poppins(),),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(color: kAccentColor),
                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Text("Send Money",
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: kAccentColor,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: size.height * 0.01,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const AddContact(),
                    ...List.generate(
                        contacts.length,
                        (index) => CircularContactCard(
                            name: contacts[index]["name"]!,
                            image:
                                "assets/images/${contacts[index]["image"]!}"))
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SendMethod(
                      text: "From Clipboard",
                      width: size.width * 0.46,
                      icon: Icons.paste_outlined,
                      onTap: () {
                        showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) {
                            TextEditingController addressController =
                                TextEditingController();
                            TextEditingController amountController =
                                TextEditingController();
                            Clipboard.getData('text/plain').then((data) {
                              try {
                                addressController.text = data!.text!;
                              } catch (e) {
                                addressController.text = "Nothing in clipboad!";
                              }
                            });
                            return Container(
                              decoration: const BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Send Trannsaction",
                                      style: GoogleFonts.poppins(
                                        color: kAccentColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: kAccentColor,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: TextFormField(
                                      controller: addressController,
                                      keyboardType: TextInputType.text,
                                      decoration: const InputDecoration(
                                        hintText: 'Destination Address',
                                        border: InputBorder.none,
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: kAccentColor,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: TextFormField(
                                      controller: amountController,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        hintText: 'Amount',
                                        prefixText: 'ETH ',
                                        border: InputBorder.none,
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                      ),
                                    ),
                                  ),
                                  XButton(
                                    text: "Send",
                                    color: kAccentColor,
                                    textColor: kPrimaryColor,
                                    onTap: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.transparent,
                                          content: Container(
                                            height: 48,
                                            color: kPrimaryColor,
                                            child: Text(
                                              "Transaction  sent to miners",
                                              style: GoogleFonts.poppins(),
                                            ),
                                          ),
                                        ),
                                      );
                                      SharedPreferences.getInstance()
                                          .then((prefs) {
                                        getWalletCreds(prefs
                                                .getString("currentWallet")!)
                                            .then((wally) {
                                          Web3Services()
                                              .sendTransaction(
                                            wally!.privateKey,
                                            addressController.text,
                                            double.parse(amountController.text),
                                          )
                                              .then((result) {
                                            debugPrint(
                                                "transaction result: $result");
                                          });
                                        });
                                      });
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }),
                  SendMethod(
                      text: "Scan QR Code",
                      width: size.width * 0.46,
                      icon: Icons.qr_code_scanner_outlined,
                      onTap: () {}),
                ],
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Recent Transactions",
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: kAccentColor,
                          fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Text("All",
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: kAccentColor,
                              fontWeight: FontWeight.bold)),
                      const Icon(
                        Icons.chevron_right_outlined,
                        color: Colors.white,
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              ...List.generate(
                  5,
                  (index) => TransactionCard(
                      size: size,
                      account: "Jack",
                      amount: 100,
                      direction: index))
            ],
          ),
        ),
      ),
    );
  }
}

class ListIndicatior extends StatelessWidget {
  const ListIndicatior({
    Key? key,
    required this.index,
    required this.indicatorIndex,
  }) : super(key: key);
  final int index;
  final int indicatorIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 2),
      width: index == indicatorIndex ? 16 : 6,
      height: 6,
      decoration: BoxDecoration(
          color: index == indicatorIndex ? kPrimaryColor : kAccentColor,
          borderRadius: BorderRadius.circular(6)),
    );
  }
}

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    Key? key,
    required this.size,
    required this.account,
    required this.amount,
    required this.direction,
  }) : super(key: key);

  final Size size;
  final String account;
  final double amount;
  final int direction;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.black.withAlpha(60),
          borderRadius: BorderRadius.circular(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(account,
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: kAccentColor,
                      fontWeight: FontWeight.w500)),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text("\$ $amount",
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: kAccentColor,
                      fontWeight: FontWeight.w500)),
            ],
          ),
          Container(
            width: 50,
            height: 30,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: direction.isEven ? Colors.greenAccent : Colors.redAccent,
                borderRadius: BorderRadius.circular(16)),
            child: Center(
              child: Text(direction.isEven ? "IN" : "OUT",
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: kAccentColor,
                      fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }
}
