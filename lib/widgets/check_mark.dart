import 'package:flutter/material.dart';

class CheckMark extends StatelessWidget {
  CheckMark(this.checked);
  final bool checked;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      left: checked ? 0 : -28,
      bottom: checked ? 0 : -28,
      duration: Duration(milliseconds: 300),
      curve: standardEasing,
      child: Container(
        width: 28,
        height: 28,
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
