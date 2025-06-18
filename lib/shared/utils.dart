import 'package:url_launcher/url_launcher.dart';

void openLink(String? url) {
  if (url != null) {
    launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
  }
}
