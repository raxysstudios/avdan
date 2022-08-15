import 'package:avdan/modules/news/news.dart';
import 'package:avdan/modules/news/services/fetcher.dart';
import 'package:avdan/shared/prefs.dart';
import 'package:flutter/material.dart';

Future<void> checkNews(BuildContext context) async {
  final current = await getNewestUpdate(lrnLng);
  if (current.isAfter(pstUpd)) await openNews(context);
}

Future<void> openNews(BuildContext context) {
  return Navigator.push(
    context,
    MaterialPageRoute<void>(
      builder: (context) => const NewsScreen(),
    ),
  );
}
