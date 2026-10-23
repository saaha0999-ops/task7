class PageCache35 {
  final int capacity;
  final Map<String, String> _pages = {};

  PageCache35(this.capacity);

  void open(String route, String title) {
    _pages.remove(route);
    _pages[route] = title;
    if (_pages.length > capacity) {
      final oldest = _pages.keys.first;
      _pages.remove(oldest);
      print("  Удалена из кэша: $oldest");
    }
  }

  List<String> get routes => _pages.keys.toList();
}

void main() {
  print("\n=== Задание 35. Кэш экранов (LRU-концепт) ===");
  final cache = PageCache35(5);
  for (final r in ["/home", "/catalog", "/cart", "/profile", "/settings", "/catalog", "/about", "/help"]) {
    print("Открыта $r");
    cache.open(r, "Экран $r");
  }
  print("В кэше: ${cache.routes}");
}
