import 'package:avdan/models/post.dart';
import 'package:avdan/modules/news/services/queries.dart';
import 'package:avdan/shared/prefs.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'widgets/news_card.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    super.initState();
    Prefs.lastReadNews = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Новости'),
      ),
      body: FirestoreListView<Post>(
        query: getPostsQuery(Prefs.interfaceLanguage),
        padding: const EdgeInsets.only(top: 16, bottom: 32),
        itemBuilder: (context, snapshot) {
          final post = snapshot.data();
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: NewsCard(post),
            // isHighlighted: post.created.isAfter(pstUpd),
          );
        },
      ),
    );
  }
}
