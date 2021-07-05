import 'translation.dart';

class Language {
  final Translation name;
  final bool interface;
  final bool learning;
  final String? alt;
  final String? flag;

  const Language(
    this.name, {
    this.interface = false,
    this.learning = false,
    this.alt,
    this.flag,
  });

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      Translation.fromJson(json['name']),
      interface: (json['interface'] ?? false) as bool,
      learning: (json['learning'] ?? false) as bool,
      alt: json['alt'],
      flag: json['flag'],
    );
  }
}
