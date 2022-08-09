import 'package:avdan/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

Future<List<Post>> fetchPosts(
  String language, {
  DocumentSnapshot? startAfter,
  int limit = 10,
  ValueSetter<DocumentSnapshot>? lastDoc,
}) async {
  var query = FirebaseFirestore.instance
      .collection('posts')
      .withConverter(
        fromFirestore: (s, _) => Post.fromJson(s.data()!),
        toFirestore: (_, __) => {},
      )
      .where('language', isEqualTo: language)
      .orderBy('created', descending: true)
      .limit(limit);
  if (startAfter != null) {
    query = query.startAfterDocument(startAfter);
  }
  final snap = await query.get();
  lastDoc?.call(snap.docs.last);
  return snap.docs.map((d) => d.data()).toList();
}

Future<int> getNewestStamp(String language) {
  return fetchPosts(language).then(
    (ps) => ps.isEmpty ? 0 : ps.first.created.millisecondsSinceEpoch,
  );
}
