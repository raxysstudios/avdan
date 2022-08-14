import 'package:flutter/material.dart';

class LoadingChip extends StatelessWidget {
  const LoadingChip(
    this.loaded,
    this.total, {
    super.key,
  });
  final int? loaded;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: loaded == null
          ? null
          : loaded! < total || total == 0
              ? const CircularProgressIndicator()
              : const Icon(Icons.check_outlined),
      label: Text(
        loaded == 0
            ? '...'
            : [
                loaded,
                if ((loaded ?? 0) < total) total,
              ].join(' / '),
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
