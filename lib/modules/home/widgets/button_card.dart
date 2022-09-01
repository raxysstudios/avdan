import 'package:flutter/material.dart';

class ButtonCard extends StatefulWidget {
  const ButtonCard({
    required this.onTap,
    required this.child,
    super.key,
  });
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
      shape: const StadiumBorder(),
      elevation: 2 * (isHover ? 3 : 1),
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: widget.onTap,
        onTapDown: (_) => setState(() {
          isHover = true;
        }),
        onTapCancel: () => setState(() {
          isHover = false;
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
