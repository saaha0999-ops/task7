Set<String> cleanPhoneBook(List<String?> raw) {
  final result = <String>{};
  for (final entry in raw) {
    if (entry == null) continue;
    final digits = entry.replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) continue;

    String normalized;
    if (digits.length == 11 && (digits.startsWith('8') || digits.startsWith('7'))) {
      normalized = "7${digits.substring(1)}";
    } else if (digits.length == 10) {
      normalized = "7$digits";
    } else {
      continue;
    }
    result.add("+$normalized");
  }
  return result;
}

void main() {
  print("\n=== Задание 49. Пайплайн очистки телефонной книги ===");
  final raw = <String?>[
    "+7 (999) 123-45-67",
    "89991234567",
    null,
    "",
    "   ",
    "9991234567",
    "abc",
    "+7 (912) 000-11-22",
    "12345",
  ];
  print(cleanPhoneBook(raw));
}
