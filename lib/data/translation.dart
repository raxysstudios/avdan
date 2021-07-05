import 'package:avdan/data/language.dart';
import 'package:avdan/store.dart';

class Translation {
  final Map<String, String> map;
  const Translation(this.map);

  String? get global => map['english'];
  String? get native => map[global];
  String? get learning => _resolveAlt(Store.learning);
  String? get interface => _resolveAlt(Store.interface);

  String? _resolveAlt(Language language) {
    var global = language.name.global;
    if (global == null) return null;
    if (Store.alt && language.alt != null) global += '_alt';
    return map[global];
  }

  factory Translation.fromJson(dynamic json) {
    return Translation(
      Map.castFrom<String, dynamic, String, String>(
        json as Map<String, dynamic>,
      ),
    );
  }
}
