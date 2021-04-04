import 'package:flutter/material.dart';
import 'chapters.dart';

class HomeScreen extends StatelessWidget {
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
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChaptersScreen(
                      language: 'Digoron',
                    ),
                    maintainState: false,
                  ),
                ),
              ),
              TextButton(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Iron", style: TextStyle(fontSize: 24)),
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChaptersScreen(
                      language: 'Iron',
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
