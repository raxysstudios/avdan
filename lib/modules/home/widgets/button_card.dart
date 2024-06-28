import 'package:flutter/material.dart';

class ButtonCard extends StatefulWidget {
  const ButtonCard({
    required this.onTap,
    required this.child,
    this.color,
    super.key,
  });
  final Color? color;
  final VoidCallback onTap;
  final Widget child;

  @override
  State<ButtonCard> createState() => _ButtonCardState();
}

class _ButtonCardState extends State<ButtonCard> {
  var isHover = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.color,
      shape: const StadiumBorder(),
      elevation: isHover ? 12 : 6,
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: widget.onTap,
        onHighlightChanged: (v) => setState(() {
          isHover = v;
        }),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
