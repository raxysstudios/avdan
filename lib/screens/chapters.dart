import 'package:flutter/material.dart';
import '../data/store.dart';

class ChaptersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                children: List.generate(
                  33,
                  (index) => Center(
                    child: TextButton(
                      child: Text('Item $index'),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              height: 96,
              child: ListView.separated(
                itemCount: chapters.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0)
                    return ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.home),
                          Text("Home"),
                        ],
                      ),
                    );
                  return TextButton(
                    onPressed: () {},
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
                  );
                },
                separatorBuilder: (context, index) => SizedBox(width: 8),
                scrollDirection: Axis.horizontal,
              ),
              // child: ListView.builder(
              //   itemCount: chapters.length,
              //   itemBuilder: (context, index) => ElevatedButton(
              //     onPressed: () => Navigator.pop(context),
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Icon(Icons.home),
              //         Text(chapters[index].name),
              //       ],
              //     ),
              //   ),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
