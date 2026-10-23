({double total, double discountAmount, bool isFreeDelivery}) analyzeCart(
  List<Map<String, dynamic>> cart,
) {
  double total = 0;
  double discountAmount = 0;

  for (final item in cart) {
    final price = (item["price"] as num).toDouble();
    final qty = (item["qty"] as num?)?.toInt() ?? 1;
    final discountPercent = (item["discount"] as num?)?.toDouble() ?? 0.0;

    final gross = price * qty;
    final discount = gross * discountPercent / 100;

    discountAmount += discount;
    total += gross - discount;
  }

  return (total: total, discountAmount: discountAmount, isFreeDelivery: total >= 2000);
}

Set<String> extractCategories(List<Map<String, dynamic>> cart) {
  return cart.map((item) => item["category"] as String? ?? "Без категории").toSet();
}

void main() {
  print("\n=== Задание 50. Итоговый аналитический модуль корзины ===");
  final cart = <Map<String, dynamic>>[
    {"name": "Чехол для телефона", "category": "Аксессуары", "price": 500, "qty": 2, "discount": 10},
    {"name": "Наушники", "category": "Электроника", "price": 1500.0, "qty": 1},
    {"name": "Кабель USB-C", "category": "Аксессуары", "price": 300, "qty": 1, "discount": 0},
  ];

  final result = analyzeCart(cart);
  print("Категории: ${extractCategories(cart)}");
  print("Итого к оплате: ${result.total.toStringAsFixed(2)} ₽");
  print("Сумма скидок: ${result.discountAmount.toStringAsFixed(2)} ₽");
  print("Бесплатная доставка: ${result.isFreeDelivery ? "да" : "нет"}");

  final small = analyzeCart([
    {"name": "Ручка", "category": "Канцелярия", "price": 50, "qty": 3},
  ]);
  print("Малая корзина: $small");
}
