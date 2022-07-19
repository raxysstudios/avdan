import 'package:avdan/models/post.dart';
import 'package:avdan/modules/home/home.dart';
import 'package:avdan/shared/widgets/column_card.dart';
import 'package:avdan/shared/widgets/markdown_text.dart';
import 'package:avdan/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  static const _pageSize = 25;
  final _paging = PagingController<QueryDocumentSnapshot?, Post>(
    firstPageKey: null,
  );

  @override
  void initState() {
    super.initState();
    _paging.addPageRequestListener(_fetchPage);
  }

  @override
  void dispose() {
    _paging.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(QueryDocumentSnapshot? start) async {
    var query = FirebaseFirestore.instance
        .collection('posts')
        .withConverter(
          fromFirestore: (s, _) => Post.fromJson(s.data()!),
          toFirestore: (_, __) => {},
        )
        .where('language', isEqualTo: context.read<Store>().interface.id)
        .orderBy('created', descending: true)
        .limit(_pageSize);
    if (start != null) {
      query = query.startAfterDocument(start);
    }
    final snap = await query.get();
    final posts = snap.docs.map((d) => d.data()).toList();
    if (posts.length < _pageSize) {
      _paging.appendLastPage(posts);
    } else {
      _paging.appendPage(posts, snap.docs[snap.size - 1]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final store = context.read<Store>();
    return Scaffold(
      appBar: AppBar(
        title: Text(store.localize('news')),
      ),
      body: PagedListView(
        pagingController: _paging,
        padding: const EdgeInsets.only(bottom: 76),
        builderDelegate: PagedChildBuilderDelegate<Post>(
          itemBuilder: (context, post, _) {
            return ColumnCard(
              divider: const SizedBox(height: 8),
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  post.title,
                  style: textTheme.headline5?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  post.created.toIso8601String().substring(0, 10),
                  style: textTheme.caption?.copyWith(
                    fontSize: 14,
                  ),
                ),
                MarkdownText(post.body),
              ],
            );
          },
        ),
      ),
    );
  }
}
