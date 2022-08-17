import 'package:avdan/shared/extensions.dart';
import 'package:flutter/material.dart';

class AltToggle extends StatelessWidget {
  const AltToggle(
    this.value, {
    required this.off,
    required this.on,
    required this.onToggled,
    super.key,
  });
  final bool value;
  final String off;
  final String on;
  final ValueSetter<bool> onToggled;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onToggled(!value),
      child: Row(
        children: [
          Text(off.titled),
          Switch(
            value: value,
            onChanged: onToggled,
          ),
          Text(on.titled),
        ],
      ),
    );
  }
}
