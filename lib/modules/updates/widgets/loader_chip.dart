import 'package:flutter/material.dart';

class LoaderChip extends StatelessWidget {
  const LoaderChip(
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
          : loaded! >= total
              ? const Icon(Icons.done_outline)
              : const CircularProgressIndicator(),
      label: Text(
        [
          loaded,
          if ((loaded ?? 0) < total) total,
        ].join(' / '),
      ),
    );
  }
}
