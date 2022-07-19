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
      created: DateTime.fromMillisecondsSinceEpoch(json['created'] as int),
    );
  }
}
