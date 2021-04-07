import 'package:flutter/material.dart';

class CheckMark extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8),
          ),
        ),
        child: Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
    );
  }
}
