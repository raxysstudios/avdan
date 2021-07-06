import 'package:avdan/store.dart';

class Translation {
  final Map<String, String> map;
  const Translation(this.map);

  String? get global => map['english'];
  String? get interface => map[Store.interface.name.global];
  String? get learning {
    final learning = map[Store.learning.name.global];
    if (!Store.alt) return learning;
    return map[Store.learning.alt] ?? learning;
  }

  factory Translation.fromJson(dynamic json) {
    return Translation(
      Map.castFrom<String, dynamic, String, String>(
        json as Map<String, dynamic>,
      ),
    );
  }
}
