List<String> missingKeys(Map<String, dynamic> json, List<String> requiredKeys) {
  return requiredKeys.where((k) => !json.containsKey(k)).toList();
}

void main() {
  print("\n=== Задание 38. Валидация обязательных JSON-полей ===");
  const requiredKeys = ["status", "data", "timestamp"];
  final ok = <String, dynamic>{"status": "ok", "data": [], "timestamp": 1700000000};
  final bad = <String, dynamic>{"status": "ok"};

  for (final json in [ok, bad]) {
    final missing = missingKeys(json, requiredKeys);
    print(missing.isEmpty ? "Ответ валиден" : "Отсутствуют поля: $missing");
  }
  print("Через every: ${requiredKeys.every(ok.containsKey)}");
}
