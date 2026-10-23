class TodoTask22 {
  final String title;
  final bool isCompleted;
  const TodoTask22(this.title, this.isCompleted);

  @override
  String toString() => title;
}

void main() {
  print("\n=== Задание 22. Удаление завершенных задач из To-Do списка ===");
  final tasks = [
    const TodoTask22("Купить хлеб", true),
    const TodoTask22("Сделать практическую", false),
    const TodoTask22("Позвонить маме", false),
    const TodoTask22("Оплатить интернет", true),
  ];
  final active = tasks.where((t) => t.isCompleted == false).toList();
  print("Активные задачи: $active");

  tasks.removeWhere((t) => t.isCompleted);
  print("После removeWhere: $tasks");
}
