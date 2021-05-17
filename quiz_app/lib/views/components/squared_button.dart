import 'package:flutter/material.dart';

class SquaredButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Icon icon;
  final Function onclick;

  const SquaredButton(
      {Key key, this.width, this.height, this.color, this.icon, this.onclick});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.rectangle,
      ),
      width: width,
      height: height,
      child: IconButton(
        icon: icon,
        enableFeedback: true,
        onPressed: onclick,
      ),
    );
  }
}
