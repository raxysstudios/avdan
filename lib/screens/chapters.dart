import 'package:flutter/material.dart';

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
                (ModalRoute.of(context)?.settings?.arguments ?? "Null language")
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
              child: ListView(scrollDirection: Axis.horizontal, children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.home),
                      Text("Home"),
                    ],
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
