import 'package:avdan/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Query<Post> getPostsQuery(String language) {
  return FirebaseFirestore.instance
      .collection('posts')
      .withConverter(
        fromFirestore: (s, _) => Post.fromJson(s.data()!),
        toFirestore: (_, __) => {},
      )
      .where('language', isEqualTo: language)
      .orderBy('created', descending: true);
}

Future<DateTime> getNewestUpdate(String language) async {
  final snapshot = await getPostsQuery(language).limit(1).get();
  if (snapshot.size == 0) return DateTime(0);
  return snapshot.docs.first.data().created;
}
