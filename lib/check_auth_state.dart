import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:xcrypt/screens/login/login_screen.dart';
import 'package:xcrypt/screens/nav_page/nav_page.dart';

class CheckAuthState extends StatelessWidget {
  const CheckAuthState({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const NavScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
