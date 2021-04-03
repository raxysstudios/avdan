import 'package:flutter/material.dart';
import 'package:avdan/data/store.dart';
import './chapter_items.dart';

class ChaptersScreen extends StatefulWidget {
  @override
  _ChaptersScreenState createState() => _ChaptersScreenState();
}

class _ChaptersScreenState extends State<ChaptersScreen> {
  int _chapter = 0;

  void _setChapter(int _chapter) {
    setState(() {
      this._chapter = _chapter;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  (ModalRoute.of(context)?.settings.arguments ?? "Null")
                      as String,
                  style: TextStyle(fontSize: 24),
                ),
              ),
              ChapterItems(chapter: chapters[_chapter]),
              Container(
                padding: const EdgeInsets.all(8),
                height: 96,
                child: ListView.separated(
                  itemCount: chapters.length + 1,
                  itemBuilder: (context, index) => index == 0
                      ? ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.home),
                              Text("Home"),
                            ],
                          ),
                        )
                      : TextButton(
                          onPressed: () => _setChapter(index - 1),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.home),
                                Text(chapters[index - 1].name),
                              ],
                            ),
                          ),
                        ),
                  separatorBuilder: (context, index) => SizedBox(width: 8),
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
          ),
        ),
      );
}
