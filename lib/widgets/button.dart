import 'package:flutter/material.dart';

import 'color.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback? press;
  final Color? color, textColor;

  const Button({
    Key? key,
    required this.text,
    this.press,
    this.color,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: screenSize.width*0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: FlatButton(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          color: HexColor.fromHex("#66c0f4"),
          onPressed: press,
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
