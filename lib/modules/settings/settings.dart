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
      appBar: AppBar(
        title: Text(localize('settings')),
        actions: const [
          Padding(
            padding: EdgeInsets.all(12),
            child: Raxys(),
          ),
          SizedBox(width: 4),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => openLink('https://t.me/raxysstudios'),
        icon: const Icon(Icons.send_outlined),
        label: Text(localize('contact')),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ListTile(
                  onTap: () => openLink('https://raxys.app'),
                  leading: const Icon(Icons.landscape_outlined),
                  title: const Text('Raxys Studios'),
                  subtitle: Text(localize('honor', isTitled: false)),
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
          const SliverPadding(
            padding: EdgeInsets.only(bottom: 76),
          )
        ],
      ),
    );
  }
}
