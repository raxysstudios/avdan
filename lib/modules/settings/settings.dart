import 'package:avdan/models/post.dart';
import 'package:avdan/modules/settings/widgets/version_tile.dart';
import 'package:avdan/shared/localizations.dart';
import 'package:avdan/shared/prefs.dart';
import 'package:avdan/shared/utils.dart';
import 'package:avdan/shared/widgets/raxys.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'services/fetcher.dart';
import 'widgets/news_sliver.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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

  @override
  void dispose() {
    _paging.dispose();
    super.dispose();
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            forceElevated: true,
            title: Text(localize('settings')),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Tooltip(
                  message: localize('honor', isTitled: false),
                  waitDuration: Duration.zero,
                  child: const Raxys(
                    size: 48,
                    scale: 3.5,
                  ),
                ),
              )
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ListTile(
                  onTap: () => openLink('https://t.me/raxysstudios'),
                  leading: const Icon(Icons.send_outlined),
                  title: const Text('Raxys Studios'),
                  subtitle: Text(localize('contact')),
                ),
                const VersionTile(),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: ListTile(
                    leading: const Icon(Icons.notifications_outlined),
                    title: Text(
                      localize('news'),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const NewsSliver(),
        ],
      ),
    );
  }
}
