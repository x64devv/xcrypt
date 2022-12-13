import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../chat/chat_screen.dart';
import '../home/home_screen.dart';
import '../market/market_screen.dart';
import '../profile/profile_screen.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({super.key, });

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int navIndex = 0;
  List navScreens = [];

  @override
  void initState() {
    navScreens = [
      HomeScreen(

      ),
      const MarketScreen(),
      const ChatScreen(),
      const ProfileScreen(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navScreens[navIndex],
      bottomNavigationBar: Container(
        height: 48,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: kPrimaryColor,
          currentIndex: navIndex,
          onTap: (index) {
            setState(() {
              navIndex = index;
            });
          },
          selectedItemColor: kAccentColor,
          unselectedItemColor: kAccentColor.withAlpha(100),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          iconSize: 18,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_rounded,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.data_thresholding_rounded,
                ),
                label: "Market"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.chat_bubble_rounded,
                ),
                label: "Chat"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_circle_rounded,
                ),
                label: "Profile"),
          ],
        ),
      ),
    );
  }
}
