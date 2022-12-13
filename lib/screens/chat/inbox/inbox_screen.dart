import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/profile_image.dart';
import '../../../constants.dart';
import '../../../model/contact_model.dart';
import 'components/body.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key, required this.contact});
  final ContactModel contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.chevron_left_rounded, color: kAccentColor)),
        title: Row(
          children: [
            Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8),
              child: ProfileImage(image: contact.image),
            ),
            Text(
              contact.name,
              style: GoogleFonts.poppins(
                  color: kAccentColor, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert_rounded,
                color: kAccentColor,
              ))
        ],
      ),
      body: SafeArea(child: Body()),
    );
  }
}
