import 'package:avdan/models/post.dart';
import 'package:avdan/modules/news/news.dart';
import 'package:avdan/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void checkNews(BuildContext context) async {
  final id = await FirebaseFirestore.instance
      .collection('posts')
      .withConverter(
        fromFirestore: (s, _) => Post.fromJson(s.data()!),
        toFirestore: (_, __) => {},
      )
      .where('language', isEqualTo: context.read<Store>().interface)
      .orderBy('created', descending: true)
      .limit(1)
      .get()
      .then((q) => q.size == 0 ? null : q.docs.first.id);
  final prefs = await SharedPreferences.getInstance();
  if (prefs.getString('lastPostId') != id && id != null) {
    await openNews(context);
    await prefs.setString('lastPostId', id);
  }
}

Future<void> openNews(BuildContext context) {
  return Navigator.push(
    context,
    MaterialPageRoute<void>(
      builder: (context) => const NewsScreen(),
    ),
  );
}
