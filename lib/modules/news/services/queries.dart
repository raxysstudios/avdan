import 'package:avdan/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Query<Post> getPostsQuery(String language) {
  return FirebaseFirestore.instance
      .collection('posts')
      .withConverter(
        fromFirestore: (s, _) => Post.fromJson(s.data()!),
        toFirestore: (o, __) => o.toJson(),
      )
      .where('language', isEqualTo: language)
      .orderBy('created', descending: true);
}
