import 'package:avdan/models/post.dart';
import 'package:avdan/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';

class NewsCard extends StatelessWidget {
  const NewsCard(
    this.post, {
    super.key,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          post.title,
          style: theme.textTheme.titleLarge,
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 4,
            bottom: 10,
          ),
          child: Text(
            DateFormat('dd.MM.yyyy').format(post.created),
            style: theme.textTheme.labelLarge,
          ),
        ),
        MarkdownBody(
          data: post.body,
          styleSheet: MarkdownStyleSheet(
            p: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 15,
                ),
          ),
          onTapLink: (_, link, __) => openLink(link),
        ),
      ],
    );
  }
}
