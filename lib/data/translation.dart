class Translation {
  const Translation(this._map);

  final Map<String, String> _map;

  Iterable<String> get keys => _map.keys;
  Iterable<String> get values => _map.values;

  String? get(String? key) => _map[key];
  String get id => get('english')!;

  factory Translation.fromJson(dynamic json) {
    return Translation(
      Map.castFrom<String, dynamic, String, String>(
        json as Map<String, dynamic>,
      ),
    );
  }
}
