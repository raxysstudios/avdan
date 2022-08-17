import 'package:avdan/models/language.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Language>> fetchLanguages() {
  return FirebaseFirestore.instance
      .collection('languages')
      .withConverter(
        fromFirestore: (s, _) => Language.fromJson(s.data()!),
        toFirestore: (_, __) => {},
      )
      .orderBy('name')
      .get()
      .then((s) => s.docs.map((d) => d.data()).toList());
}
