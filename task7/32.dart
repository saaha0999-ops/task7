class User32 {
  final int id;
  final String name;
  const User32(this.id, this.name);

  @override
  String toString() => "User($id, $name)";
}

void main() {
  print("\n=== Задание 32. Конвертация списка в ассоциативную карту ===");
  const users = [User32(1, "Анна"), User32(2, "Борис"), User32(3, "Вера")];

  final Map<int, User32> byId = {for (final u in users) u.id: u};
  print(byId);
  print("Пользователь с id=2: ${byId[2]}");
  print("Пользователь с id=9: ${byId[9]}");
}
