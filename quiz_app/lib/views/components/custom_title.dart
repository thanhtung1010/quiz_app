import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  final Icon icon1;
  final Text text;
  final Icon icon2;
  final Function press;
  const CustomTitle({Key key, this.icon1, this.text, this.icon2, this.press})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey[400]),
          ),
        ),
        child: InkWell(
          splashColor: Colors.blueAccent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: icon1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: text,
                  ),
                ],
              ),
              icon2,
            ],
          ),
          onTap: press,
        ),
      ),
    );
  }
}
