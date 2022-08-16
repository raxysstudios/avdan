import 'package:avdan/modules/updates/models/deck_preview.dart';
import 'package:flutter/material.dart';

class StatusIcon extends StatelessWidget {
  const StatusIcon(
    this.status, {
    super.key,
  });
  final DeckStatus status;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircularProgressIndicator(
          value:
              status == DeckStatus.downloading || status == DeckStatus.unpacking
                  ? null
                  : 0,
        ),
        if (status == DeckStatus.ready)
          const Icon(Icons.done_outlined)
        else
          Icon(
            status == DeckStatus.pending
                ? Icons.update_outlined
                : status == DeckStatus.downloading
                    ? Icons.file_download_outlined
                    : Icons.unarchive_outlined,
            size: 20,
          ),
      ],
    );
  }
}
