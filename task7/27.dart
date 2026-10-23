bool listsEqual<T>(List<T> a, List<T> b) {
  if (a.length != b.length) return false;
  for (int i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}

void main() {
  print("\n=== Задание 27. Проверка идентичности двух списков ===");
  print(listsEqual([1, 2, 3], [1, 2, 3]));
  print(listsEqual([1, 2, 3], [3, 2, 1]));
  print(listsEqual(["a"], ["a", "b"]));
  print(listsEqual<int>([], []));
}
