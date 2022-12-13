import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/add_contact_card.dart';
import '../../../components/circular_contact_card.dart';
import '../../../components/profile_image.dart';
import '../../../components/search_field.dart';
import '../../../constants.dart';
import '../../../model/contact_model.dart';
import '../inbox/inbox_screen.dart';

class Body extends StatelessWidget {
  Body({super.key});

  Function(String) searchChat = (String query) {
    debugPrint("Search term: $query");
  };

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      padding: const EdgeInsets.only(
        top: 28,
      ),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [kPrimaryColor, kPrimaryGradientColor2],
      )),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: SearchField(hint: "Search chat...", onPress: searchChat),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const AddContact(),
                  ...List.generate(
                      8,
                      (index) => const CircularContactCard(
                          name: "John Doe",
                          image: "assets/images/avatar_4.jpeg"))
                ],
              ),
            ),
            Divider(
              color: kAccentColor.withOpacity(0.6),
            ),
            ...List.generate(
                8,
                (index) => GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          ContactModel contact = ContactModel();
                          contact.name = "Jack Jones";
                          contact.image = 'assets/images/avatar_4.jpeg';
                          return (InboxScreen(contact: contact));
                        }));
                      },
                      child: Container(
                        height: 65,
                        padding: const EdgeInsets.only(
                          left: 8,
                          right: 8,
                          bottom: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(60),
                        ),
                        child: Row(
                          children: [
                            const ProfileImage(
                                image: "assets/images/avatar_4.jpeg"),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "John Doe",
                                    style: GoogleFonts.poppins(
                                        fontSize: 16, color: kAccentColor),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Hi John, this is my test message to you. This extra message is to see how it overflows.",
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                        fontSize: 12, color: kAccentColor),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  )),
                              child: Center(
                                child: Text(
                                  "2",
                                  style: GoogleFonts.poppins(
                                      fontSize: 12, color: kAccentColor),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ))
          ],
        ),
      ),
    );
  }
}
