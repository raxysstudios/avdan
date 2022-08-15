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
    return Row(
      children: [
        if (status == DeckStatus.downloading || status == DeckStatus.unpacking)
          const Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircularProgressIndicator(),
          ),
        Icon(
          status == DeckStatus.pending
              ? Icons.update_outlined
              : status == DeckStatus.downloading
                  ? Icons.file_download_outlined
                  : status == DeckStatus.unpacking
                      ? Icons.unarchive_outlined
                      : Icons.done_outlined,
        ),
      ],
    );
  }
}
