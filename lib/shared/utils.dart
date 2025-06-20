import 'package:avdan/models/converters/timestamp_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

void openLink(String? url) {
  if (url != null) {
    launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
  }
}

Future<bool> checkDocUpdate(
  String docPath,
  DateTime localUpdated,
) async {
  final doc = await FirebaseFirestore.instance.doc(docPath).get();
  final serverUpdated = const TimestampConverter().fromJson(
    doc.get('lastUpdated'),
  );
  return serverUpdated.isAfter(localUpdated);
}
