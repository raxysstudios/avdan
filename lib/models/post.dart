import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String title;
  final String body;
  final DateTime created;

  const Post({
    required this.title,
    required this.body,
    required this.created,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      title: json['title'] as String,
      body: json['body'] as String,
      created: (json['created'] as Timestamp).toDate(),
    );
  }
}
