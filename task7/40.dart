String toQueryString(Map<String, dynamic> params) {
  return params.entries
      .where((e) => e.value != null)
      .map((e) => "${Uri.encodeQueryComponent(e.key)}=${Uri.encodeQueryComponent(e.value.toString())}")
      .join("&");
}

void main() {
  print("\n=== Задание 40. Сериализация параметров фильтра в URL ===");
  print(toQueryString({"brand": "Apple", "minPrice": 50000}));
  print(toQueryString({"q": "умные часы", "inStock": true, "sort": null}));
}
