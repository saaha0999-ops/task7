class Product28 {
  final String name;
  final String category;
  const Product28(this.name, this.category);
}

void main() {
  print("\n=== Задание 28. Извлечение уникальных категорий ===");
  const products = [
    Product28("Футболка", "Одежда"),
    Product28("Ноутбук", "Электроника"),
    Product28("Джинсы", "Одежда"),
    Product28("Книга", "Книги"),
    Product28("Смартфон", "Электроника"),
  ];
  final List<String> categories = products.map((p) => p.category).toSet().toList();
  print("Категории: $categories");
}
