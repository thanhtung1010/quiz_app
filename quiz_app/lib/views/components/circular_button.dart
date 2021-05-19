import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Icon icon;
  final Function onclick;
  final String hinttext;

  const CircularButton({
    Key key,
    this.width,
    this.height,
    this.color,
    this.icon,
    this.onclick,
    this.hinttext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      width: width,
      height: height,
      child: IconButton(
        icon: icon,
        enableFeedback: true,
        onPressed: onclick,
        tooltip: hinttext,
      ),
    );
  }
}
