List<List<T>> chunk<T>(List<T> list, int size) {
  final pages = <List<T>>[];
  for (int i = 0; i < list.length; i += size) {
    final end = i + size > list.length ? list.length : i + size;
    pages.add(list.sublist(i, end));
  }
  return pages;
}

void main() {
  print("\n=== Задание 30. Постраничная группировка (Chunking) ===");
  final items = List.generate(100, (i) => i + 1);
  final pages = chunk(items, 10);
  print("Страниц: ${pages.length}");
  print("Первая страница: ${pages.first}");
  print("Последняя страница: ${pages.last}");
}
