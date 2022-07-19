import 'package:avdan/modules/news/news.dart';
import 'package:avdan/modules/news/services/fetcher.dart';
import 'package:avdan/store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void checkNews(BuildContext context) async {
  final current = await getNewestStamp(context.read<Store>().interface.id);
  final last = await SharedPreferences.getInstance().then(
    (prefs) => prefs.getInt('lastPost') ?? 0,
  );
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
