import 'package:flutter/material.dart';

class SelectableCard extends StatelessWidget {
  SelectableCard({
    required this.children,
    this.selected = false,
    this.elevated = false,
    this.onTap,
  });

  final List<Widget> children;
  final bool selected;
  final bool elevated;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    const size = 28.0;
    return Card(
      elevation: elevated ? Theme.of(context).cardTheme.elevation : 0,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            ...children,
            AnimatedPositioned(
              left: selected ? 0 : -size,
              bottom: selected ? 0 : -size,
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
