import 'package:flutter/material.dart';

class ChaptersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () => Navigator.pop(context), child: Text("Home"))
          ],
        ),
      ),
    );
  }
}
