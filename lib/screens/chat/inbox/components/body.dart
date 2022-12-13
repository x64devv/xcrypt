import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../components/input_field.dart';
import '../../../../constants.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Container(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
          child: Column(children: [
            MessegeBubble(),
          ]),
        )),
        Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.only(bottom: 8, right: 8, left: 8),
          decoration: BoxDecoration(
              color: Colors.black.withAlpha(80),
              borderRadius: BorderRadius.circular(32)),
          child: Row(
            children: [
              const SizedBox(width: 18),
              Expanded(
                child: InputField(
                    keyBoardType: TextInputType.text,
                    hintText: "Type message here...",
                    prefixIcon: Icons.keyboard,
                    validator: (value) {},
                    onChanged: (value) {}),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.send, color: kAccentColor))
            ],
          ),
        )
      ],
    );
  }
}

class MessegeBubble extends StatelessWidget {
  const MessegeBubble({
    Key? key,
  }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.black.withAlpha(60),
          borderRadius: BorderRadius.circular(16)),
      child: Text(
        "This is message one",
        style: GoogleFonts.poppins(color: kAccentColor, fontSize: 12),
      ),
    );
  }
}
