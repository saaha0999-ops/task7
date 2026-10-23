class Product21 {
  final String name;
  final double price;
  const Product21(this.name, this.price);

  @override
  String toString() => "$name (${price.toStringAsFixed(0)} ₽)";
}

List<Product21> filterByPrice(List<Product21> items, double min, double max) {
  return items.where((p) => p.price >= min && p.price <= max).toList();
}

void main() {
  print("\n=== Задание 21. Фильтр каталога по диапазону цен ===");
  const catalog = [
    Product21("Мышь", 1200),
    Product21("Клавиатура", 3500),
    Product21("Монитор", 18000),
    Product21("Наушники", 4800),
  ];
  print("От 1000 до 5000: ${filterByPrice(catalog, 1000, 5000)}");
}
