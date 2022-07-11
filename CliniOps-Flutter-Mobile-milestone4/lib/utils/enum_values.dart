class EnumValues<T1, T2> {
  Map<T1, T2> map;
  late Map<T2, T1> _reverseMap;

  EnumValues(this.map);

  Map<T2, T1> get reverse {
    _reverseMap = map.map((k, v) => MapEntry(v, k));
    return _reverseMap;
  }
}
