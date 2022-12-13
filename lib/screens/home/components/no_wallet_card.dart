import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3dart/credentials.dart';
import 'package:xcrypt/components/input_field.dart';
import 'package:xcrypt/components/x_button.dart';
import 'package:xcrypt/model/database_services.dart';
import 'package:xcrypt/model/web3_services.dart';

import '../../../constants.dart';

class NoWalletsCard extends StatelessWidget {
  NoWalletsCard({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;
  String walletName = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      width: size.width * 0.95,
      height: size.height * 0.3,
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Looks like you have no wallets here yet!",
            style: GoogleFonts.poppins(color: kAccentColor, fontSize: 12),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: kAccentColor),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextButton(
                  child: Text(
                    "Create New Wallet",
                    style: GoogleFonts.poppins(
                      color: kAccentColor,
                      fontSize: 12,
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: CreateNewWalletDialog(),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: kAccentColor),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextButton(
                  child: Text(
                    "Load Wallet File",
                    style: GoogleFonts.poppins(
                      color: kAccentColor,
                      fontSize: 12,
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: Container(
                            height: 250,
                            width: 250,
                            color: kPrimaryColor,
                            child: Column(
                              children: [
                                Text(
                                  'Load your wallet from json file',
                                  style: GoogleFonts.poppins(
                                    color: kAccentColor,
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                XButton(
                                  text: "Select file...",
                                  color: kAccentColor,
                                  textColor: kPrimaryColor,
                                  onTap: () {
                                    FilePicker.platform.pickFiles().then(
                                      (selectedFile) {
                                        Navigator.pop(context);
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              final formKey =
                                                  GlobalKey<FormState>();
                                              return Form(
                                                key: formKey,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "New Wallet Creation",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: kAccentColor,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    InputField(
                                                      keyBoardType:
                                                          TextInputType.text,
                                                      hintText:
                                                          "Enter wallet name",
                                                      prefixIcon:
                                                          Icons.account_circle,
                                                      validator: (value) {
                                                        if (value.length < 3) {
                                                          return "Name too short";
                                                        }
                                                        return null;
                                                      },
                                                      onChanged: (value) {
                                                        walletName = value;
                                                      },
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    InputField(
                                                      keyBoardType:
                                                          TextInputType.text,
                                                      hintText:
                                                          "Enter wallet password",
                                                      prefixIcon: Icons.lock,
                                                      validator: (value) {
                                                        if (value.length < 8) {
                                                          return "Password too short";
                                                        }
                                                        return null;
                                                      },
                                                      onChanged: (value) {
                                                        password = value;
                                                      },
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    XButton(
                                                      text: "Save",
                                                      color: kAccentColor,
                                                      textColor: kPrimaryColor,
                                                      onTap: () {
                                                        if (formKey
                                                            .currentState!
                                                            .validate()) {
                                                          formKey.currentState!
                                                              .save();
                                                          SharedPreferences
                                                                  .getInstance()
                                                              .then((prefs) {
                                                            prefs.setString(
                                                                walletName,
                                                                password);
                                                          });
                                                          DBService()
                                                              .addWallet({
                                                            "filename":
                                                                selectedFile!
                                                                    .files
                                                                    .single
                                                                    .path,
                                                            "walletName":
                                                                walletName,
                                                          }).then((value) {
                                                            if (value) {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                    "Reload home to complete set up",
                                                                    style: GoogleFonts
                                                                        .poppins(
                                                                      color:
                                                                          kAccentColor,
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                          });
                                                        }
                                                      },
                                                    )
                                                  ],
                                                ),
                                              );
                                            });
                                      },
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CreateNewWalletDialog extends StatefulWidget {
  const CreateNewWalletDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateNewWalletDialog> createState() => _CreateNewWalletDialogState();
}

class _CreateNewWalletDialogState extends State<CreateNewWalletDialog> {
  String walletName = '';
  String password = '';
  late Wallet wally;
  bool isCreating = true;
  final _formKey = GlobalKey<FormState>();
  late SharedPreferences prefs;

  loadPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    loadPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kPrimaryColor,
      ),
      height: 250,
      padding: const EdgeInsets.all(8),
      child: isCreating
          ? Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    "New Wallet Creation",
                    style: GoogleFonts.poppins(
                      color: kAccentColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  InputField(
                    keyBoardType: TextInputType.text,
                    hintText: "Enter wallet name",
                    prefixIcon: Icons.account_circle,
                    validator: (value) {
                      if (value.length < 3) {
                        return "Name too short";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      walletName = value;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  InputField(
                    keyBoardType: TextInputType.text,
                    hintText: "Enter wallet password",
                    prefixIcon: Icons.lock,
                    validator: (value) {
                      if (value.length < 8) {
                        return "Password too short";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  XButton(
                    text: "Save",
                    color: kAccentColor,
                    textColor: kPrimaryColor,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        setState(() {
                          wally = Web3Services().createNewWallet(password);
                          prefs.setString(walletName, password);

                          debugPrint(
                              'Adreess : ${wally.privateKey.address.toString()}');
                          isCreating = false;
                        });
                      }
                    },
                  )
                ],
              ),
            )
          : Container(
              height: 250,
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: kPrimaryColor,
              ),
              child: Column(
                children: [
                  Text(
                    "Save your wallet file!",
                    style: GoogleFonts.poppins(
                      color: kAccentColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  XButton(
                    text: "Save $walletName.json",
                    color: kAccentColor,
                    textColor: kPrimaryColor,
                    onTap: () {
                      FilePicker.platform
                          .getDirectoryPath()
                          .then((selectedDirectory) {
                        if (selectedDirectory != null) {
                          writeFile(wally.toJson(), selectedDirectory,
                                  '$walletName.json')
                              .then((success) {
                            if (success) {
                              DBService().addWallet({
                                'filename':
                                    '$selectedDirectory/$walletName.json',
                                'walletName': walletName
                              }).then((value) {
                                debugPrint('$walletName insertion: $value');
                              });
                            }
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Could not save wallet file!'),
                            ),
                          );
                        }
                      });
                    },
                  )
                ],
              ),
            ),
    );
  }
}
