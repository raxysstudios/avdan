import 'package:avdan/store.dart';

class Translation {
  final Map<String, String> map;
  const Translation(this.map);

  String? get global => map['english'];
  String? get native => map[global];
  String? get learning => map[learningLanguage.name.global];
  String? get interface => map[interfaceLanguage.name.global];

  factory Translation.fromJson(dynamic json) {
    return Translation(
      Map.castFrom<String, dynamic, String, String>(
        json as Map<String, dynamic>,
      ),
    );
  }
}
