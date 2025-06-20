import 'package:avdan/shared/prefs.dart';
import 'package:avdan/shared/utils.dart';

Future<bool> checkUpdates() async {
  final language = Prefs.learningLanguage;
  if (language == null) return false;
  return await checkDocUpdate(
    'languages/${language.name}',
    language.lastUpdated,
  );
}
