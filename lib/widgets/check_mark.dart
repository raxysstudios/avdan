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
    return Align(
      alignment: Alignment.bottomLeft,
      child: AnimatedOpacity(
        opacity: widget.checked ? 1 : 0,
        duration: Duration(milliseconds: 250),
        curve: standardEasing,
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8),
            ),
          ),
          child: Icon(
            Icons.check,
            color: Colors.white,
            size: 18,
          ),
        ),
      ),
    );
  }
}
