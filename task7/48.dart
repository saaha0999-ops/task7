String volumeMessage(int volume) {
  return switch (volume) {
    int v when v < 0 || v > 100 => "Некорректное значение: $v",
    int v when v > 80 => "Слишком громко!",
    int v when v == 0 => "Звук выключен",
    int v when v < 20 => "Тихо",
    _ => "Комфортная громкость",
  };
}

void main() {
  print("\n=== Задание 48. Обработка диапазона громкости через Switch Guard ===");
  for (final v in [-5, 0, 10, 50, 85, 120]) {
    print("$v -> ${volumeMessage(v)}");
  }
}
