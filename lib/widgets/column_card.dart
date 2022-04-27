import 'package:flutter/material.dart';

class ColumnCard extends StatelessWidget {
  const ColumnCard({
    required this.children,
    this.header,
    this.margin = const EdgeInsets.only(top: 16),
    this.divider = true,
    Key? key,
  }) : super(key: key);

  final EdgeInsets margin;
  final String? header;
  final bool divider;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin,
      shape: const RoundedRectangleBorder(),
      child: Column(
        children: [
          if (header != null)
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                header!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          if (divider)
            for (final c in children) ...[c, const Divider()]
          else
            ...children,
        ],
      ),
    );
  }
}
