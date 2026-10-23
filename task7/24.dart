void main() {
  print("\n=== Задание 24. Склейка двух списков баннеров ===");
  final systemPromos = ["Скидки недели", "Бесплатная доставка"];
  final personalOffers = ["Кешбэк 10% на электронику", "Подарок за отзыв"];

  final banners = [...systemPromos, ...personalOffers];
  print(banners);

  List<String>? maybeOffers;
  print([...systemPromos, ...?maybeOffers]);
}
