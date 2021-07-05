import 'translations.dart';

class Language {
  const Language({
    this.interface = false,
    this.learning = false,
    this.alt,
    this.flag,
    required this.name,
  });

  final bool interface;
  final bool learning;
  final String? alt;
  final String? flag;

  final Translations name;
  String get globalName => name['english']!;
  String? get nativeName => name[globalName];

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      interface: (json['interface'] ?? false) as bool,
      learning: (json['learning'] ?? false) as bool,
      alt: json['alt'],
      flag: json['flag'],
      name: toMap(json['name']),
    );
  }
}
