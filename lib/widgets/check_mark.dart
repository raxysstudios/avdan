import 'package:flutter/material.dart';

class CheckMark extends StatefulWidget {
  CheckMark(this.checked);
  final bool checked;

  @override
  _CheckMarkState createState() => _CheckMarkState();
}

class _CheckMarkState extends State<CheckMark> {
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      left: widget.checked ? 0 : -32,
      bottom: widget.checked ? 0 : -32,
      duration: Duration(milliseconds: 300),
      curve: standardEasing,
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
