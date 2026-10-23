({bool isValid, List<String> errors}) validateRegistration({
  required String name,
  required String email,
  required String password,
  required String confirmPassword,
}) {
  final errors = <String>[];

  if (name.trim().length < 2) {
    errors.add("Имя должно содержать минимум 2 символа");
  }
  if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
    errors.add("Некорректный email");
  }
  if (password.length < 8) {
    errors.add("Пароль короче 8 символов");
  }
  if (!RegExp(r'\d').hasMatch(password)) {
    errors.add("Пароль должен содержать цифру");
  }
  if (password != confirmPassword) {
    errors.add("Пароли не совпадают");
  }

  return (isValid: errors.isEmpty, errors: errors);
}

void main() {
  print("\n=== Задание 47. Валидатор комплексной формы регистрации ===");
  final bad = validateRegistration(
    name: "А",
    email: "wrong-email",
    password: "abc",
    confirmPassword: "abd",
  );
  print("Валидно: ${bad.isValid}");
  for (final e in bad.errors) {
    print(" - $e");
  }

  final good = validateRegistration(
    name: "Анна",
    email: "anna@example.com",
    password: "Flutter2024",
    confirmPassword: "Flutter2024",
  );
  print("Валидно: ${good.isValid}, ошибок: ${good.errors.length}");
}
