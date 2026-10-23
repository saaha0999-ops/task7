Map<String, double> totalsByCategory(
  List<({String name, String category, double price, int qty})> purchases,
) {
  final totals = <String, double>{};
  for (final p in purchases) {
    final sum = p.price * p.qty;
    totals.update(p.category, (old) => old + sum, ifAbsent: () => sum);
  }
  return totals;
}

void main() {
  print("\n=== Задание 37. Подсчет суммы товаров по категориям ===");
  final purchases = <({String name, String category, double price, int qty})>[
    (name: "Хлеб", category: "Еда", price: 50.0, qty: 2),
    (name: "Молоко", category: "Еда", price: 90.5, qty: 1),
    (name: "Футболка", category: "Одежда", price: 1200.0, qty: 1),
    (name: "Кабель", category: "Электроника", price: 350.0, qty: 3),
  ];
  totalsByCategory(purchases).forEach((cat, sum) {
    print("$cat: ${sum.toStringAsFixed(2)} ₽");
  });
}
