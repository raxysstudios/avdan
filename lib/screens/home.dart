import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  void toChapters(BuildContext context, String language) =>
      Navigator.pushNamed(context, "/chapters", arguments: language);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 15),
            Text("Avdan", style: TextStyle(fontSize: 36)),
            SizedBox(height: 15),
            TextButton(
              child: Text("Digoron", style: TextStyle(fontSize: 24)),
              onPressed: () => toChapters(context, "Digoron"),
            ),
            SizedBox(height: 15),
            TextButton(
              child: Text("Iron", style: TextStyle(fontSize: 24)),
              onPressed: () => toChapters(context, "Iron"),
            )
          ],
        ),
      ),
    );
  }
}
