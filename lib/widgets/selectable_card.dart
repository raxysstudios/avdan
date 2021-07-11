import 'package:flutter/material.dart';

class SelectableCard extends StatelessWidget {
  SelectableCard({
    required this.children,
    this.selected = false,
    this.elevated = false,
    this.onTap,
    this.color,
  });

  final List<Widget> children;
  final bool selected;
  final bool elevated;
  final Function()? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    const size = 24.0;
    return Card(
      color: color,
      elevation: elevated ? Theme.of(context).cardTheme.elevation : 0,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            ...children,
            AnimatedPositioned(
              left: selected ? 0 : -size,
              bottom: 0,
              duration: Duration(milliseconds: 250),
              curve: standardEasing,
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(4),
                  ),
                ),
                child: Icon(
                  Icons.check_outlined,
                  size: size - 2,
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
