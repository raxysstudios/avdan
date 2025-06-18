import 'package:avdan/models/post.dart';
import 'package:avdan/shared/prefs.dart';
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

Future<bool> checkNews(String language) async {
  var newest = DateTime(0);

  final snapshot = await getPostsQuery(language).limit(1).get();
  if (snapshot.size > 0) {
    newest = snapshot.docs.first.data().created;
  }

  return newest.isAfter(pstUpd);
}
