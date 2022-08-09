import 'package:avdan/models/language.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Language>> fetchLanguages() async {
  final query = FirebaseFirestore.instance
      .collection('languages')
      .withConverter(
        fromFirestore: (s, _) => Language.fromJson(s.data()!),
        toFirestore: (_, __) => {},
      )
      .orderBy('name');

  final snap = await query.get();
  return snap.docs.map((d) => d.data()).toList();
}
