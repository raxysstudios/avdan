import 'package:avdan/models/post.dart';
import 'package:avdan/shared/prefs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../services/fetcher.dart';
import 'post_card.dart';

class NewsSliver extends StatefulWidget {
  const NewsSliver({super.key});

  @override
  State<NewsSliver> createState() => _NewsSliverState();
}

class _NewsSliverState extends State<NewsSliver> {
  static const _pageSize = 25;
  final _paging = PagingController<DocumentSnapshot?, Post>(
    firstPageKey: null,
  );

  late final DateTime lastPost;

  @override
  void initState() {
    super.initState();
    _paging.addPageRequestListener(_fetchPage);

    lastPost = pstUpd;
    getNewestUpdate(intLng).then((lp) {
      pstUpd = lp;
    });
  }

  Future<void> _fetchPage(DocumentSnapshot? start) async {
    late final DocumentSnapshot last;
    final posts = await fetchPosts(
      intLng,
      startAfter: start,
      limit: _pageSize,
      lastDoc: (d) {
        last = d;
      },
    );

    if (posts.length < _pageSize) {
      _paging.appendLastPage(posts);
    } else {
      _paging.appendPage(posts, last);
    }
  }

  @override
  void dispose() {
    _paging.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PagedSliverList(
      pagingController: _paging,
      builderDelegate: PagedChildBuilderDelegate<Post>(
        itemBuilder: (context, post, _) {
          return PostCard(
            post,
            isHighlighted: post.created.isAfter(lastPost),
          );
        },
      ),
    );
  }
}
