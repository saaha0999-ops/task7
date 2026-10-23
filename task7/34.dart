void main() {
  print("\n=== Задание 34. Удаление ключей с null-значениями ===");
  final payload = <String, dynamic>{
    "name": "Алексей",
    "phone": null,
    "email": "a@mail.ru",
    "avatar": null,
    "age": 25,
  };

  final cleaned = Map<String, dynamic>.from(payload)..removeWhere((key, value) => value == null);
  print("Исходная карта: $payload");
  print("Для отправки: $cleaned");
}
