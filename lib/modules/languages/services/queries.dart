import 'package:avdan/models/language.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Query<Language> getLanguagesQuery() {
  return FirebaseFirestore.instance
      .collection('languages')
      .withConverter(
        fromFirestore: (s, _) => Language.fromJson(s.data()!),
        toFirestore: (o, __) => o.toJson(),
      )
      .orderBy('order');
}
