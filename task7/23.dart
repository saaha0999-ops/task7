void main() {
  print("\n=== Задание 23. Инверсия порядка чатов ===");
  final messages = ["Привет", "Как дела?", "Всё хорошо", "Отлично!"];

  final Iterable<String> reversedView = messages.reversed;

  for (final m in reversedView) {
    print(m);
  }
  print("Исходный список не изменился: $messages");
}
