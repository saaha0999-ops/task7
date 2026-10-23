class Category39 {
  final int id;
  final int? parentId;
  final String name;
  const Category39(this.id, this.parentId, this.name);
}

Map<int?, List<Category39>> buildCategoryTree(List<Category39> flat) {
  final tree = <int?, List<Category39>>{};
  for (final c in flat) {
    tree.putIfAbsent(c.parentId, () => []).add(c);
  }
  return tree;
}

void printTree(Map<int?, List<Category39>> tree, int? parentId, int depth) {
  for (final c in tree[parentId] ?? <Category39>[]) {
    print("${'  ' * depth}- ${c.name}");
    printTree(tree, c.id, depth + 1);
  }
}

void main() {
  print("\n=== Задание 39. Построение дерева категорий ===");
  const flat = [
    Category39(1, null, "Электроника"),
    Category39(2, 1, "Телефоны"),
    Category39(3, 1, "Ноутбуки"),
    Category39(4, 2, "Смартфоны"),
    Category39(5, null, "Одежда"),
    Category39(6, 5, "Мужская"),
    Category39(7, 5, "Женская"),
  ];
  final tree = buildCategoryTree(flat);
  printTree(tree, null, 0);
}
