String handleResponse(Object? response) {
  return switch (response) {
    int code => "Код ответа: $code",
    String error => "Ошибка: $error",
    Map data => "Данные (${data.length} полей): $data",
    null => "Пустой ответ",
    _ => "Неизвестный тип: ${response.runtimeType}",
  };
}

void main() {
  print("\n=== Задание 44. Сопоставление типа ответа API ===");
  print(handleResponse(200));
  print(handleResponse("Таймаут соединения"));
  print(handleResponse({"id": 1, "name": "Тест"}));
  print(handleResponse(null));
  print(handleResponse(3.14));
}
