import 'package:avdan/modules/news/news.dart';
import 'package:avdan/modules/news/services/fetcher.dart';
import 'package:avdan/store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> checkNews(BuildContext context) async {
  final store = context.read<Store>();
  final current = await getNewestStamp(store.interface);
  final last = store.prefs.get('lastPost', defaultValue: 0) as int;
  if (last < current) await openNews(context);
}

Future<void> openNews(BuildContext context) {
  return Navigator.push(
    context,
    MaterialPageRoute<void>(
      builder: (context) => const NewsScreen(),
    ),
  );
}
