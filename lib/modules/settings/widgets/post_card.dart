import 'package:avdan/models/post.dart';
import 'package:avdan/shared/widgets/column_card.dart';
import 'package:avdan/shared/widgets/markdown_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostCard extends StatelessWidget {
  const PostCard(
    this.post, {
    this.isHighlighted = true,
    super.key,
  });

  final Post post;
  final bool isHighlighted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ColumnCard(
      divider: const SizedBox(height: 8),
      padding: const EdgeInsets.all(16),
      shape: null,
      margin: null,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                post.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (isHighlighted)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Icon(
                  Icons.new_releases_outlined,
                  color: theme.colorScheme.primary,
                ),
              ),
          ],
        ),
        MarkdownText(post.body),
        Text(
          DateFormat('dd-MM-yyyy').format(post.created),
          textAlign: TextAlign.end,
          style: theme.textTheme.caption?.copyWith(
            fontSize: 14,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}
