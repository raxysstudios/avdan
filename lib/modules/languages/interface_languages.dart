// import 'package:avdan/modules/languages/services/languages.dart';
// import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';

class InterfaceLanguages extends StatelessWidget {
  const InterfaceLanguages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Язык интерфейса'),
      ),
      // body: FirestoreListView(
      //   query: getLanguagesQuery().where(
      //     'isInterface',
      //     isEqualTo: true,
      //   ),
      //   itemBuilder: (context, doc) {
      //     final language = doc.data();
      //     return ListTile(
      //       title: Text(localize(language.name, map: language.localizations)),
      //       subtitle: Text(localize(language.name)),
      //       onTap: () async {
      //         await selectUILanguage(language);
      //         Navigator.pop(context);
      //       },
      //     );
      //   },
      // ),
    );
  }
}
