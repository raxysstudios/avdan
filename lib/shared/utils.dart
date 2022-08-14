import 'package:url_launcher/url_launcher.dart';

void openLink(String url) {
  launchUrl(
    Uri.parse(url),
    mode: LaunchMode.externalApplication,
  );
}

String capitalize(String? text) {
  if (text == null) return '';
  return text
      .split(' ')
      .where((s) => s.isNotEmpty)
      .map((w) => w[0].toUpperCase() + w.substring(1))
      .join(' ')
      .split('-')
      .where((s) => s.isNotEmpty)
      .map((w) => w[0].toUpperCase() + w.substring(1))
      .join('-');
}
