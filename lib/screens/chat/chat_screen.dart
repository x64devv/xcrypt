import 'package:flutter/material.dart';

import 'components/body.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});
  static String routeName = "/chat";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
