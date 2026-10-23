void main() {
  print("\n=== Задание 45. Деструктуризация координат точки в цикле ===");
  final List<(int x, int y)> points = [(0, 0), (3, 4), (-2, 5)];

  for (var (x, y) in points) {
    final distanceSquared = x * x + y * y;
    print("Точка ($x, $y), квадрат расстояния до начала координат: $distanceSquared");
  }
}
