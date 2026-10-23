void main() {
  print("\n=== Задание 33. Слияние локального и серверного профиля ===");
  final cached = <String, dynamic>{"theme": "light", "language": "ru", "fontSize": 14};
  final server = <String, dynamic>{"theme": "dark", "notifications": true};

  final merged = {...cached, ...server};
  print(merged);

  final copy = Map<String, dynamic>.from(cached)..addAll(server);
  print(copy);
}
