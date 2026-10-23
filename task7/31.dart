({int id, String name, int age, String email, bool isPremium}) parseProfile(
  Map<String, dynamic> json,
) {
  return (
    id: json["id"] as int? ?? 0,
    name: json["name"] as String? ?? "Гость",
    age: (json["age"] as num?)?.toInt() ?? 0,
    email: json["email"] as String? ?? "не указан",
    isPremium: json["isPremium"] as bool? ?? false,
  );
}

void main() {
  print("\n=== Задание 31. Десериализация профиля ===");
  final full = <String, dynamic>{
    "id": 7,
    "name": "Мария",
    "age": 28,
    "email": "maria@example.com",
    "isPremium": true,
  };
  final partial = <String, dynamic>{"id": 8, "age": 31.0};

  print(parseProfile(full));
  print(parseProfile(partial));
  print(parseProfile({}));
}
