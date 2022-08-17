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
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 4,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: () => onToggled(!value),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  off.titled,
                  textAlign: TextAlign.center,
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
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
