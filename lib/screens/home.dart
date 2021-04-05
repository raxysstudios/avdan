import 'package:avdan/data/chapter.dart';
import 'package:avdan/data/store.dart';
import 'package:avdan/screens/settings.dart';
import 'package:avdan/widgets/chapter_item.dart';
import 'package:avdan/widgets/item_view.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Chapter chapter = chapters[0];
  Map<String, String> item = chapters[0].items[0];

  var styleSelected = TextButton.styleFrom(
    backgroundColor: Colors.blue[50],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        capitalize(learningLanguage),
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsScreen()),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: FractionallySizedBox(
                  widthFactor: 1,
                  child: ItemView(translations: item),
                ),
              ),
              Container(
                height: 128,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => TextButton(
                    onPressed: () =>
                        setState(() => item = chapter.items[index]),
                    child: ChapterItem(
                      translations: chapter.items[index],
                    ),
                    style: item == chapter.items[index]
                        ? styleSelected
                        : TextButton.styleFrom(),
                  ),
                  separatorBuilder: (context, index) => SizedBox(width: 8),
                  itemCount: chapter.items.length,
                ),
              ),
              Container(
                height: 96,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => TextButton(
                    onPressed: () => setState(() {
                      chapter = chapters[index];
                      item = chapter.items[0];
                    }),
                    child: ChapterItem(
                      translations: chapters[index].translations,
                    ),
                    style: chapter == chapters[index]
                        ? styleSelected
                        : TextButton.styleFrom(),
                  ),
                  separatorBuilder: (context, index) => SizedBox(width: 8),
                  itemCount: chapters.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    // return  DefaultTabController(
    //   length: chapters.length,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       bottom: TabBar(
    //         tabs: [
    //           for (var chapter in chapters)
    //             Tab(
    //               text: capitalize(chapter.translations['english'] ?? ''),
    //             ),
    //         ],
    //       ),
    //       title: Text(
    //         capitalize(learningLanguage),
    //       ),
    //     ),
    //     body: TabBarView(
    //       children: [
    //         for (var chapter in chapters)
    //           ChapterGrid(
    //             chapter: chapter,
    //           ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
