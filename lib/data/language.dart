import 'translation.dart';

class Language {
  final Translation name;
  final String flag;
  final String? alt;
  final bool interface;
  final bool learning;

  const Language(
    this.name, {
    required this.flag,
    this.interface = false,
    this.learning = false,
    this.alt,
  });

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      Translation.fromJson(json['name']),
      flag: json['flag'],
      alt: json['alt'],
      interface: (json['interface'] ?? false) as bool,
      learning: (json['learning'] ?? false) as bool,
    );
  }
}
