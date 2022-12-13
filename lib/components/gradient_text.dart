import 'package:flutter/material.dart';
class GradientText extends StatelessWidget {
  const GradientText({Key? key, required this.gradient, required this.text, required this.style}) : super(key: key);
  final String text;
  final Gradient gradient;
  final TextStyle style;
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: Text(text, style: style,),
    );
  }
}