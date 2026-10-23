class Product25 {
  final String name;
  final double rating;
  const Product25(this.name, this.rating);

  @override
  String toString() => "$name ($rating)";
}

void main() {
  print("\n=== Задание 25. Поиск максимального элемента без библиотек ===");
  const products = [
    Product25("Чайник", 4.3),
    Product25("Блендер", 4.8),
    Product25("Тостер", 3.9),
  ];
  final best = products.reduce((a, b) => a.rating >= b.rating ? a : b);
  print("Лучший товар: $best");
}
