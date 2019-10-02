import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OutlinedTextField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  OutlinedTextField({
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: EdgeInsets.only(right: 16),
      child: TextField(
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.blueAccent),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8)
        ),
        onChanged: this.onChanged,
        maxLines: 1,
      ),
    );
  }
}
