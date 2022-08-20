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
    return ListTile(
      onTap: () => onToggled(!value),
      leading: const Icon(Icons.swap_horiz_outlined),
      title: Row(
        children: [
          Expanded(
            child: Text(
              off.titled,
              style: const TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onToggled,
          ),
          Expanded(
            child: Text(
              on.titled,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
