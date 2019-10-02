import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomActionButton extends StatelessWidget {

  final String text;
  final void Function() onPressed;

  BottomActionButton({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      color: Colors.blueAccent,
      disabledColor: Colors.grey,
      textColor: Colors.white,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      onPressed: onPressed,
    );
  }

}