import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xcrypt/model/web_service.dart';

import '../../../check_auth_state.dart';
import '../../../components/input_field.dart';
import '../../../components/logo.dart';
import '../../../components/x_button.dart';
import '../../../constants.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [kPrimaryColor, kPrimaryGradientColor2],
      )),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.25),
              const Logo(),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Hi,there",
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: kAccentColor,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Let's login to continue :)",
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: kAccentColor,
                    fontWeight: FontWeight.w300),
              ),
              const SizedBox(
                height: 120,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputField(
                        keyBoardType: TextInputType.emailAddress,
                        prefixIcon: Icons.mail_outline,
                        hintText: "Enter email",
                        onChanged: (value) {
                          email = value;
                        },
                        validator: (value) {
                          if (!EmailValidator.validate(value)) {
                            return "Please enter valid email";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      InputField(
                        keyBoardType: TextInputType.visiblePassword,
                        prefixIcon: Icons.lock,
                        hintText: "Enter password",
                        onChanged: (value) {
                          password = value;
                        },
                        validator: (value) {
                          if (value.isEmpty || value.length < 8) {
                            return "Password should be at least 8 characters long.";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      XButton(
                        text: "Sign in",
                        color: kPrimaryColor,
                        textColor: kAccentColor,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            showDialog(
                              context: context,
                              builder: (context) {
                                WebService()
                                    .signIn(email, password)
                                    .then((value) {
                                  Navigator.pop(context);
                                  if (!value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Container(
                                          height: 60,
                                          padding: const EdgeInsets.all(8),
                                          child: Center(
                                            child: Row(
                                              children: const [
                                                Icon(
                                                  Icons.cancel_rounded,
                                                  color: kAccentColor,
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Text("Ooops Sign in Failed!")
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const CheckAuthState(),
                                        ));
                                  }
                                });
                                return Dialog(
                                  child: Container(
                                    height: 150,
                                    width: 150,
                                    color: kPrimaryColor,
                                    padding: const EdgeInsets.all(8),
                                    child: Center(
                                      child: Text("Please Wait!...", style: GoogleFonts.poppins(color: kAccentColor,),),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      XButton(
                        text: "Sign up",
                        color: kPrimaryColor,
                        textColor: kAccentColor,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            showDialog(
                              context: context,
                              builder: (context) {
                                WebService()
                                    .signUp(email, password)
                                    .then((value) {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Container(
                                        height: 60,
                                        padding: const EdgeInsets.all(8),
                                        child: Center(
                                          child: Row(
                                            children: const [
                                              Icon(
                                                Icons.cancel_rounded,
                                                color: kAccentColor,
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text("Ooops Sign up Failed!")
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                });
                                return Container(
                                  height: 150,
                                  width: 150,
                                  color: kAccentColor,
                                  padding: const EdgeInsets.all(8),
                                  child: const Center(
                                    child: Text("Please Wait!..."),
                                  ),
                                );
                              },
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CheckAuthState(),
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class ToastBar extends StatelessWidget {
  const ToastBar({
    Key? key,
    required this.text,
    required this.icon,
    required this.color,
    required this.textColor,
    required this.iconColor,
  }) : super(key: key);
  final String text;
  final IconData icon;
  final Color color, textColor, iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Icon(
            icon,
            color: iconColor,
          ),
          Text(
            text,
            style: GoogleFonts.poppins(fontSize: 12, color: textColor),
          ),
        ],
      ),
    );
  }
}
