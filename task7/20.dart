List<String> extractHashtags(String message) {
  return RegExp(r'#[\p{L}\p{N}_]+', unicode: true)
      .allMatches(message)
      .map((m) => m.group(0)!)
      .toList();
}

void main() {
  print("\n=== Задание 20. Выделение тегов из текста ===");
  const post = "Сегодня изучаю #Flutter и #Dart! Отличный день для #мобильная_разработка.";
  print(extractHashtags(post));
}
