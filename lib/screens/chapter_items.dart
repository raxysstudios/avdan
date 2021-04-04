import 'package:avdan/data/store.dart';
import 'package:flutter/material.dart';
import 'package:avdan/data/chapter.dart';
import 'package:avdan/audio-player.dart';

class ChapterItems extends StatelessWidget {
  ChapterItems({required this.chapter});
  final Chapter chapter;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 0.9,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8),
      itemCount: chapter.items.length,
      itemBuilder: (context, index) {
        var name = chapter.items[index]['english'] ?? '';
        return TextButton(
          onPressed: () async {
            if (audioPlayer.playing) audioPlayer.stop();
            await audioPlayer.setAsset('audio/$name.mp3');
            audioPlayer.play();
          },
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.asset('assets/images/$name.png'),
                ),
                Text(capitalize(chapter.items[index][targetLanguage] ?? '')),
                Text(
                  capitalize(chapter.items[index][interfaceLanguage] ?? ''),
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
