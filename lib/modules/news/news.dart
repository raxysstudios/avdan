import 'package:avdan/models/post.dart';
import 'package:avdan/modules/news/services/fetcher.dart';
import 'package:avdan/modules/news/widgets/post_card.dart';
import 'package:avdan/shared/localizations.dart';
import 'package:avdan/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  static const _pageSize = 25;
  final _paging = PagingController<DocumentSnapshot?, Post>(
    firstPageKey: null,
  );

  var lastPost = 0;
  late final String language;

  @override
  void initState() {
    super.initState();
    final store = context.read<Store>();
    language = store.interface;
    _paging.addPageRequestListener(_fetchPage);

    lastPost = store.prefs.get(
      'lastPost',
      defaultValue: 0,
    ) as int;
    getNewestStamp(language).then(
      (lp) => store.prefs.put(
        'lastPost',
        lp,
      ),
    );
  }

  @override
  void dispose() {
    _paging.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(DocumentSnapshot? start) async {
    late final DocumentSnapshot last;
    final posts = await fetchPosts(
      language,
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(localize('news')),
      ),
      body: PagedListView(
        pagingController: _paging,
        padding: const EdgeInsets.only(bottom: 76),
        builderDelegate: PagedChildBuilderDelegate<Post>(
          itemBuilder: (context, post, _) {
            return PostCard(
              post,
              isHighlighted: lastPost < post.created.millisecondsSinceEpoch,
            );
          },
        ),
      ),
    );
  }
}
