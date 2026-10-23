String resolveState(bool isLoading, bool hasError) {
  return switch ((isLoading: isLoading, hasError: hasError)) {
    (isLoading: true, hasError: false) => "Загрузка...",
    (isLoading: false, hasError: true) => "Произошла ошибка. Повторите попытку",
    (isLoading: false, hasError: false) => "Данные успешно загружены",
    (isLoading: true, hasError: true) => "Повторная загрузка после ошибки...",
  };
}

void main() {
  print("\n=== Задание 42. Резолвер состояний загрузки (Pattern Matching) ===");
  print(resolveState(true, false));
  print(resolveState(false, true));
  print(resolveState(false, false));
  print(resolveState(true, true));
}
