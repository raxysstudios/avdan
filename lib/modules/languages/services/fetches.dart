import 'package:avdan/models/language.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Language>> fetchLanguages() {
  return FirebaseFirestore.instance
      .collection('languages')
      .withConverter(
        fromFirestore: (s, _) => Language.fromJson(s.data()!),
        toFirestore: (o, __) => o.toJson(),
      )
      .orderBy('order')
      .get()
      .then((s) => s.docs.map((d) => d.data()).toList());
}

Future<Language?> fetchLanguage(String name) {
  return FirebaseFirestore.instance
      .doc('languages/$name')
      .withConverter(
        fromFirestore: (s, _) => Language.fromJson(s.data()!),
        toFirestore: (o, __) => o.toJson(),
      )
      .get()
      .then((s) => s.data());
}
