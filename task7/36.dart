Map<String, String>? invertMap(Map<String, String> source) {
  if (source.values.toSet().length != source.length) return null;
  return {for (final e in source.entries) e.value: e.key};
}

void main() {
  print("\n=== Задание 36. Инверсия карты ===");
  print(invertMap({"ru": "Россия", "de": "Германия", "fr": "Франция"}));
  print(invertMap({"a": "один", "b": "один"}));
}
