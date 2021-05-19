import 'package:flutter/material.dart';

class SelectableCard extends StatelessWidget {
  SelectableCard({
    required this.children,
    this.selected = false,
    this.onTap,
  });

  final List<Widget> children;
  final bool selected;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            ...children,
            AnimatedPositioned(
              left: selected ? 0 : -28,
              bottom: selected ? 0 : -28,
              duration: Duration(milliseconds: 250),
              curve: standardEasing,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(4),
                  ),
                ),
                child: Icon(
                  Icons.check,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
