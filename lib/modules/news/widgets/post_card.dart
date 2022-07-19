import 'package:avdan/models/post.dart';
import 'package:avdan/shared/widgets/column_card.dart';
import 'package:avdan/shared/widgets/markdown_text.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  const PostCard(
    this.post, {
    this.highlight = true,
    Key? key,
  }) : super(key: key);

  final Post post;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ColumnCard(
      divider: const SizedBox(height: 8),
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                post.title * 10,
                style: textTheme.headline5?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            // if (highlight)
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Icon(Icons.new_releases_outlined),
            ),
          ],
        ),
        Text(
          post.created.toIso8601String().substring(0, 10),
          style: textTheme.caption?.copyWith(
            fontSize: 14,
          ),
        ),
        MarkdownText(post.body),
      ],
    );
  }
}
