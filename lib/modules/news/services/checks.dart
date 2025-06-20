import 'package:avdan/shared/prefs.dart';

import 'queries.dart';

Future<bool> checkNews() async {
  final snapshot = await getPostsQuery(Prefs.interfaceLanguage)
      .where('created', isGreaterThan: Prefs.lastReadNews)
      .limit(1)
      .get();
  return snapshot.size > 0;
}
