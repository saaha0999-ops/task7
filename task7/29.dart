class Product29 {
  final String name;
  final bool inStock;
  final double price;
  const Product29(this.name, this.inStock, this.price);

  @override
  String toString() => "$name | ${inStock ? 'в наличии' : 'нет'} | ${price.toStringAsFixed(0)} ₽";
}

void main() {
  print("\n=== Задание 29. Сортировка списка по нескольким полям ===");
  final products = [
    const Product29("Планшет", false, 25000),
    const Product29("Чехол", true, 800),
    const Product29("Смартфон", true, 30000),
    const Product29("Зарядка", true, 1200),
    const Product29("Колонка", false, 5000),
  ];

  products.sort((a, b) {
    if (a.inStock != b.inStock) return a.inStock ? -1 : 1;
    return a.price.compareTo(b.price);
  });

  for (final p in products) {
    print(p);
  }
}
