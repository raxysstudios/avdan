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
  if (snap.size > 0) lastDoc?.call(snap.docs.last);
  return snap.docs.map((d) => d.data()).toList();
}

Future<DateTime> getNewestUpdate(String language) {
  return fetchPosts(
    language,
    limit: 1,
  ).then(
    (ps) => ps.isEmpty ? DateTime(0) : ps.first.created,
  );
}
