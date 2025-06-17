import 'package:avdan/models/post.dart';
import 'package:avdan/modules/news/services/fetcher.dart';
import 'package:avdan/shared/localizations.dart';
import 'package:avdan/shared/prefs.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'widgets/post_card.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(localize('news')),
      ),
      body: FirestoreListView<Post>(
        query: getPostsQuery(intLng),
        pageSize: 25,
        itemBuilder: (context, snapshot) {
          final post = snapshot.data();
          return PostCard(
            post,
            isHighlighted: post.created.isAfter(pstUpd),
          );
        },
        loadingBuilder: (_) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
