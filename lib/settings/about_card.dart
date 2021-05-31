import 'package:flutter/material.dart';

class AboutCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 172,
            width: 112,
            child: Image.asset(
              "assets/hohag.png",
              fit: BoxFit.fitHeight,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Hohag",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Developed in Ossetia & Dagestan, North Caucasus.",
                    textAlign: TextAlign.center,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.mail),
                    label: Text("Contact"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.free_breakfast),
                    label: Text("Donate"),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
