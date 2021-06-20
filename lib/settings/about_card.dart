import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // height: 172,
            height: 140,
            width: 112,
            child: Image.asset(
              'assets/hohag.png',
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
                    'Hohag',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Made with honor in Ossetia & Dagestan, North Caucasus.',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: () => launch('https://t.me/alixandzinadAX'),
                    icon: Icon(Icons.mail_outlined),
                    label: Text('Contact'),
                  ),
                  // ElevatedButton.icon(
                  //   onPressed: () {},
                  //   icon: Icon(Icons.free_breakfast_outlined),
                  //   label: Text('Donate'),
                  // ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
