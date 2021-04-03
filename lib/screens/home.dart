import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  void toChapters(BuildContext context, String language) =>
      Navigator.pushNamed(context, "/chapters", arguments: language);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Column(
            children: [
              Text("Avdan", style: TextStyle(fontSize: 36)),
              TextButton(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Digoron", style: TextStyle(fontSize: 24)),
                ),
                onPressed: () => toChapters(context, "Digoron"),
              ),
              TextButton(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Iron", style: TextStyle(fontSize: 24)),
                ),
                onPressed: () => toChapters(context, "Iron"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
