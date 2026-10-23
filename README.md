// ============================================================================
// Практическая работа №7. Основные типы данных и безопасность типов в Dart
// ============================================================================

// ----------------------------------------------------------------------------
// Тема 1, задание 1. Конвертер валют
// ----------------------------------------------------------------------------
String convertRubToUsd(int rub, double rate) {
  if (rate <= 0) return "Некорректный курс";
  final usd = rub / rate;
  return "${usd.toStringAsFixed(2)} \$";
}

void t1_1() {
  print("\n=== Тема 1, задание 1. Конвертер валют ===");
  print("10000 ₽ при курсе 92.5 = ${convertRubToUsd(10000, 92.5)}");
  print("2500 ₽ при курсе 91.37 = ${convertRubToUsd(2500, 91.37)}");
  print("500 ₽ при курсе 0 = ${convertRubToUsd(500, 0)}");
}

// ----------------------------------------------------------------------------
// Тема 1, задание 2. Безопасный калькулятор возраста
// ----------------------------------------------------------------------------
int parseAge(String input) {
  final age = int.tryParse(input.trim());
  if (age == null || age < 0 || age > 150) return -1;
  return age;
}

void t1_2() {
  print("\n=== Тема 1, задание 2. Безопасный калькулятор возраста ===");
  for (final s in ["25", " 42 ", "abc", "-5", "200", "3.5", ""]) {
    print("\"$s\" -> ${parseAge(s)}");
  }
}

// ----------------------------------------------------------------------------
// Тема 1, задание 3. Расчет плотности пикселей (DP)
// ----------------------------------------------------------------------------
double pxToDp(double px, double density) => px / density;

// Целочисленное деление: результат int, дробная часть отбрасывается
int pxToDpInt(int px, double density) => px ~/ density;

void t1_3() {
  print("\n=== Тема 1, задание 3. Расчет плотности пикселей (DP) ===");
  const int widthPx = 1080;
  const double density = 2.625;
  print("Ширина: $widthPx px, плотность: $density");
  print("Дробное деление (/): ${pxToDp(widthPx.toDouble(), density).toStringAsFixed(2)} dp");
  print("Целочисленное деление (~/): ${pxToDpInt(widthPx, density)} dp");
}

// ----------------------------------------------------------------------------
// Тема 1, задание 4. Побитовые флаги сенсоров
// ----------------------------------------------------------------------------
const int sensorAccelerometer = 1 << 0; // 001
const int sensorGyroscope = 1 << 1; // 010
const int sensorGps = 1 << 2; // 100

bool hasSensor(int state, int sensor) => (state & sensor) != 0;

String showBits(int state) => state.toRadixString(2).padLeft(3, '0');

void t1_4() {
  print("\n=== Тема 1, задание 4. Побитовые флаги сенсоров ===");
  int state = 0;

  // Включаем акселерометр и GPS (оператор |)
  state |= sensorAccelerometer;
  state |= sensorGps;
  print("Состояние: ${showBits(state)} (десятичное: $state)");
  print("Акселерометр включен: ${hasSensor(state, sensorAccelerometer)}");
  print("Гироскоп включен: ${hasSensor(state, sensorGyroscope)}");
  print("GPS включен: ${hasSensor(state, sensorGps)}");

  // Выключаем GPS (оператор & с инверсией маски)
  state &= ~sensorGps;
  print("После отключения GPS: ${showBits(state)}");

  // Переключаем гироскоп (XOR)
  state ^= sensorGyroscope;
  print("После переключения гироскопа: ${showBits(state)}");
}

// ----------------------------------------------------------------------------
// Тема 1, задание 5. Проверка четности без остатка от деления
// ----------------------------------------------------------------------------
// Побитовое «И» с 1 оставляет только младший бит: 0 — четное, 1 — нечетное
bool isEvenBit(int number) => (number & 1) == 0;

void t1_5() {
  print("\n=== Тема 1, задание 5. Проверка четности без остатка от деления ===");
  for (final n in [0, 1, 2, 7, 10, 101, -4, -3]) {
    print("$n -> ${isEvenBit(n) ? "четное" : "нечетное"}");
  }
}

// ----------------------------------------------------------------------------
// Тема 2, задание 1. Маскирование email
// ----------------------------------------------------------------------------
String maskEmail(String email) {
  final at = email.indexOf('@');
  if (at <= 0) return email;
  final local = email.substring(0, at);
  final domain = email.substring(at);
  if (local.length <= 2) {
    return "${'*' * local.length}$domain";
  }
  final stars = '*' * (local.length - 2);
  return "${local[0]}$stars${local[local.length - 1]}$domain";
}

void t2_1() {
  print("\n=== Тема 2, задание 1. Маскирование email ===");
  print(maskEmail("ivanov.flutter@gmail.com")); // i************r@gmail.com
  print(maskEmail("ab@mail.ru"));
  print(maskEmail("not-an-email"));
}

// ----------------------------------------------------------------------------
// Тема 2, задание 2. Валидатор префикса ссылки
// ----------------------------------------------------------------------------
bool isSecureUrl(String url) => url.trim().toLowerCase().startsWith("https://");

void t2_2() {
  print("\n=== Тема 2, задание 2. Валидатор префикса ссылки ===");
  for (final url in [
    "https://flutter.dev",
    "http://flutter.dev",
    "  HTTPS://dart.dev  ",
    "ftp://files.example.com",
    "flutter.dev",
  ]) {
    print("\"$url\" -> ${isSecureUrl(url)}");
  }
}

// ----------------------------------------------------------------------------
// Тема 2, задание 3. Генератор инициалов (Monogram)
// ----------------------------------------------------------------------------
String monogram(String fullName) {
  final parts = fullName
      .trim()
      .split(RegExp(r'\s+'))
      .where((p) => p.isNotEmpty);
  return parts.take(2).map((p) => p[0].toUpperCase()).join();
}

void t2_3() {
  print("\n=== Тема 2, задание 3. Генератор инициалов (Monogram) ===");
  print(monogram("Александр Пушкин")); // АП
  print(monogram("  михаил   лермонтов ")); // МЛ
  print(monogram("Гоголь")); // Г
}

// ----------------------------------------------------------------------------
// Тема 2, задание 4. Разбор CSV-строки корзины
// ----------------------------------------------------------------------------
(String name, int qty, double price)? parseCartLine(String line) {
  final parts = line.split(',');
  if (parts.length != 3) return null;
  final qty = int.tryParse(parts[1].trim());
  final price = double.tryParse(parts[2].trim());
  if (qty == null || price == null) return null;
  return (parts[0].trim(), qty, price);
}

void t2_4() {
  print("\n=== Тема 2, задание 4. Разбор CSV-строки корзины ===");
  final item = parseCartLine("Яблоко,3,150.5");
  if (item != null) {
    final (name, qty, price) = item;
    print("Товар: $name, количество: $qty, цена: $price");
    print("Сумма: ${(qty * price).toStringAsFixed(2)} ₽");
  }

  print("Битая строка: ${parseCartLine("Яблоко,три,150.5")}");
}

// ----------------------------------------------------------------------------
// Тема 2, задание 5. Подсчет реальной длины строки с эмодзи
// ----------------------------------------------------------------------------
// length считает 16-битные кодовые единицы UTF-16, runes — кодовые точки Unicode
int realLength(String text) => text.runes.length;

void t2_5() {
  print("\n=== Тема 2, задание 5. Подсчет реальной длины строки с эмодзи ===");
  const samples = ["Привет", "Привет 🚀", "Привет 🚀👍", "👨‍👩‍👧"];
  for (final s in samples) {
    print("\"$s\": length (UTF-16) = ${s.length}, runes = ${realLength(s)}");
  }
  print("Примечание: составной эмодзи 👨‍👩‍👧 состоит из нескольких кодовых точек, склеенных ZWJ.");
}

// ----------------------------------------------------------------------------
// Тема 3, задание 1. Проверка права доступа к экрану
// ----------------------------------------------------------------------------
bool canOpenScreen({
  required bool isAuthorized,
  required bool isEmailConfirmed,
  required bool isBlocked,
}) {
  return isAuthorized && isEmailConfirmed && !isBlocked;
}

void t3_1() {
  print("\n=== Тема 3, задание 1. Проверка права доступа к экрану ===");
  print(canOpenScreen(isAuthorized: true, isEmailConfirmed: true, isBlocked: false)); // true
  print(canOpenScreen(isAuthorized: true, isEmailConfirmed: false, isBlocked: false)); // false
  print(canOpenScreen(isAuthorized: true, isEmailConfirmed: true, isBlocked: true)); // false
  print(canOpenScreen(isAuthorized: false, isEmailConfirmed: true, isBlocked: false)); // false
}

// ----------------------------------------------------------------------------
// Тема 3, задание 2. Определитель пустоты строки
// ----------------------------------------------------------------------------
bool isBlank(String? input) => input == null || input.trim().isEmpty;

void t3_2() {
  print("\n=== Тема 3, задание 2. Определитель пустоты строки ===");
  for (final s in <String?>[null, "", "   ", "\n\t", "Flutter", " a "]) {
    print("${s == null ? 'null' : '"$s"'} -> ${isBlank(s)}");
  }
}

// ----------------------------------------------------------------------------
// Тема 3, задание 3. Тоггл состояния (Инвертор)
// ----------------------------------------------------------------------------
bool toggleDarkMode(bool isDarkMode) => !isDarkMode;

void t3_3() {
  print("\n=== Тема 3, задание 3. Тоггл состояния (Инвертор) ===");
  bool isDarkMode = false;
  print("Начальное состояние: $isDarkMode");
  for (int i = 1; i <= 3; i++) {
    isDarkMode = toggleDarkMode(isDarkMode);
    print("Переключение $i: ${isDarkMode ? "тёмная тема" : "светлая тема"}");
  }
}

// ----------------------------------------------------------------------------
// Тема 3, задание 4. Валидатор возраста для аренды авто
// ----------------------------------------------------------------------------
bool canRentCar(int age, int drivingExperienceYears) {
  return age >= 21 && drivingExperienceYears >= 2;
}

void t3_4() {
  print("\n=== Тема 3, задание 4. Валидатор возраста для аренды авто ===");
  print("Возраст 25, стаж 5: ${canRentCar(25, 5)}"); // true
  print("Возраст 21, стаж 2: ${canRentCar(21, 2)}"); // true (граница)
  print("Возраст 20, стаж 3: ${canRentCar(20, 3)}"); // false
  print("Возраст 30, стаж 1: ${canRentCar(30, 1)}"); // false
}

// ----------------------------------------------------------------------------
// Тема 3, задание 5. Строгая фильтрация коллекций
// ----------------------------------------------------------------------------
// В Dart нельзя писать if (balance) — нужно явное булево сравнение
bool hasPositiveBalance(double balance) => balance > 0;

void t3_5() {
  print("\n=== Тема 3, задание 5. Строгая фильтрация коллекций ===");
  final balances = [150.5, 0.0, -20.0, 0.01];
  print("Все балансы: $balances");
  print("Только строго положительные: ${balances.where(hasPositiveBalance).toList()}");
  print("Сколько нулевых и отрицательных: ${balances.where((b) => !hasPositiveBalance(b)).length}");
}

// ----------------------------------------------------------------------------
// Тема 4, задание 1. Удаление дубликатов с сохранением порядка
// ----------------------------------------------------------------------------
List<int> removeDuplicates(List<int> source) => source.toSet().toList();

void t4_1() {
  print("\n=== Тема 4, задание 1. Удаление дубликатов с сохранением порядка ===");
  final raw = [3, 1, 3, 2, 1, 5, 2, 4, 5];
  print("Исходный список: $raw");
  // Set-литерал в Dart — LinkedHashSet, поэтому порядок первого появления сохраняется
  print("Без дубликатов: ${removeDuplicates(raw)}");
}

// ----------------------------------------------------------------------------
// Тема 4, задание 2. Пагинация среза (Slice)
// ----------------------------------------------------------------------------
List<T> getPage<T>(List<T> list, int page, int pageSize) {
  if (page < 1 || pageSize < 1) return [];
  final start = (page - 1) * pageSize;
  if (start >= list.length) return [];
  final end = start + pageSize > list.length ? list.length : start + pageSize;
  return list.sublist(start, end);
}

void t4_2() {
  print("\n=== Тема 4, задание 2. Пагинация среза (Slice) ===");
  final items = List.generate(23, (i) => "Товар ${i + 1}");
  print("Страница 1: ${getPage(items, 1, 10)}");
  print("Страница 3 (неполная): ${getPage(items, 3, 10)}");
  print("Страница 4 (пустая): ${getPage(items, 4, 10)}");
}

// ----------------------------------------------------------------------------
// Тема 4, задание 3. Сортировка товаров по цене
// ----------------------------------------------------------------------------
void t4_3() {
  print("\n=== Тема 4, задание 3. Сортировка товаров по цене ===");
  final prices = <double>[499.9, 120.0, 3500.0, 89.5, 1299.0];
  print("До сортировки: $prices");
  prices.sort((a, b) => b.compareTo(a)); // по убыванию
  print("По убыванию: $prices");
  prices.sort(); // по возрастанию
  print("По возрастанию: $prices");
}

// ----------------------------------------------------------------------------
// Тема 4, задание 4. Поиск первого подходящего элемента
// ----------------------------------------------------------------------------
String findLongWord(List<String> words) {
  return words.firstWhere(
    (w) => w.length > 8,
    orElse: () => "не найдено",
  );
}

void t4_4() {
  print("\n=== Тема 4, задание 4. Поиск первого подходящего элемента ===");
  print(findLongWord(["код", "мобильный", "приложение", "виджет"])); // мобильный (первое слово длиннее 8 символов)
  print(findLongWord(["код", "дарт", "виджет"]));
}

// ----------------------------------------------------------------------------
// Тема 4, задание 5. Генератор виджетов через List.generate
// ----------------------------------------------------------------------------
void t4_5() {
  print("\n=== Тема 4, задание 5. Генератор виджетов через List.generate ===");
  final slots = List.generate(10, (i) => "Слот ${i + 1}");
  print(slots);
  print("Всего слотов: ${slots.length}");
}

// ----------------------------------------------------------------------------
// Тема 5, задание 1. Подсчет частоты слов
// ----------------------------------------------------------------------------
Map<String, int> countWords(String text) {
  final freq = <String, int>{};
  final words = RegExp(r'[\p{L}\p{N}]+', unicode: true)
      .allMatches(text.toLowerCase())
      .map((m) => m.group(0)!);
  for (final w in words) {
    freq[w] = (freq[w] ?? 0) + 1;
  }
  return freq;
}

void t5_1() {
  print("\n=== Тема 5, задание 1. Подсчет частоты слов ===");
  const text = "Dart быстрый язык. Flutter использует Dart, а Dart использует Flutter!";
  final freq = countWords(text);
  final sorted = freq.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
  for (final e in sorted) {
    print("${e.key}: ${e.value}");
  }
}

// ----------------------------------------------------------------------------
// Тема 5, задание 2. Симметрическая разность тегов
// ----------------------------------------------------------------------------
Set<String> symmetricDifference(Set<String> a, Set<String> b) {
  return a.union(b).difference(a.intersection(b));
}

void t5_2() {
  print("\n=== Тема 5, задание 2. Симметрическая разность тегов ===");
  final tagsA = {"dart", "flutter", "mobile"};
  final tagsB = {"flutter", "android", "ios"};
  print("Только в одном из множеств: ${symmetricDifference(tagsA, tagsB)}");
}

// ----------------------------------------------------------------------------
// Тема 5, задание 3. Безопасное извлечение настроек
// ----------------------------------------------------------------------------
String getNestedString(
  Map<String, dynamic> json,
  List<String> path,
  String defaultValue,
) {
  dynamic current = json;
  for (final key in path) {
    if (current is Map && current.containsKey(key)) {
      current = current[key];
    } else {
      return defaultValue;
    }
  }
  return current is String ? current : defaultValue;
}

void t5_3() {
  print("\n=== Тема 5, задание 3. Безопасное извлечение настроек ===");
  final settings = <String, dynamic>{
    "settings": {
      "theme": "dark",
      "notifications": true,
      "ui": {"language": "ru"},
    },
  };
  print(getNestedString(settings, ["settings", "theme"], "light")); // dark
  print(getNestedString(settings, ["settings", "ui", "language"], "en")); // ru
  print(getNestedString(settings, ["settings", "font"], "Roboto")); // Roboto (нет ключа)
  print(getNestedString(settings, ["settings", "notifications"], "off")); // off (не строка)
}

// ----------------------------------------------------------------------------
// Тема 5, задание 4. Трансформация карты (Map Entries)
// ----------------------------------------------------------------------------
void t5_4() {
  print("\n=== Тема 5, задание 4. Трансформация карты (Map Entries) ===");
  final pricesRub = <String, double>{
    "Наушники": 4500.0,
    "Клавиатура": 7800.0,
    "Мышь": 1990.0,
  };
  const rate = 92.5;

  final pricesUsd = pricesRub.map(
    (name, price) => MapEntry(name, double.parse((price / rate).toStringAsFixed(2))),
  );

  print("В рублях: $pricesRub");
  print("В долларах: $pricesUsd");
}

// ----------------------------------------------------------------------------
// Тема 5, задание 5. Группировка пользователей по городу
// ----------------------------------------------------------------------------
Map<String, List<Map<String, dynamic>>> groupByCity(List<Map<String, dynamic>> users) {
  final result = <String, List<Map<String, dynamic>>>{};
  for (final user in users) {
    final city = user["city"] as String? ?? "Не указан";
    result.putIfAbsent(city, () => []).add(user);
  }
  return result;
}

void t5_5() {
  print("\n=== Тема 5, задание 5. Группировка пользователей по городу ===");
  final users = <Map<String, dynamic>>[
    {"name": "Анна", "city": "Москва"},
    {"name": "Борис", "city": "Казань"},
    {"name": "Вера", "city": "Москва"},
    {"name": "Глеб"},
  ];
  groupByCity(users).forEach((city, list) {
    print("$city: ${list.map((u) => u["name"]).toList()}");
  });
}

// ----------------------------------------------------------------------------
// Тема 6, задание 1. Координаты экрана через Record
// ----------------------------------------------------------------------------
(double x, double y) screenCenter(double width, double height) {
  return (width / 2, height / 2);
}

void t6_1() {
  print("\n=== Тема 6, задание 1. Координаты экрана через Record ===");
  final (cx, cy) = screenCenter(1080, 2400);
  print("Центр экрана: x = $cx, y = $cy");

  final center = screenCenter(412, 915);
  print("Через поля записи: x = ${center.$1}, y = ${center.$2}");
}

// ----------------------------------------------------------------------------
// Тема 6, задание 2. Безопасная распаковка профиля
// ----------------------------------------------------------------------------
String resolveBio(String? bio) {
  final displayBio = bio ?? "Информация отсутствует";
  return displayBio;
}

void t6_2() {
  print("\n=== Тема 6, задание 2. Безопасная распаковка профиля ===");
  print(resolveBio(null));
  print(resolveBio("Flutter-разработчик"));

  // Оператор ??= присваивает значение, только если переменная равна null
  String? nickname;
  nickname ??= "Аноним";
  nickname ??= "Другое имя"; // не сработает: значение уже есть
  print("Ник: $nickname");
}

// ----------------------------------------------------------------------------
// Тема 6, задание 3. Pattern Matching над JSON
// ----------------------------------------------------------------------------
String checkPacket(Map<String, dynamic> json) {
  return switch (json) {
    {"id": int id} => "Валидный объект, id = $id",
    {"error": String message} => "Пакет с ошибкой: $message",
    _ => "Неизвестный формат пакета",
  };
}

void t6_3() {
  print("\n=== Тема 6, задание 3. Pattern Matching над JSON ===");
  print(checkPacket({"id": 42, "name": "Алексей"}));
  print(checkPacket({"error": "Нет доступа"}));
  print(checkPacket({"id": "строка вместо числа"}));
  print(checkPacket({}));
}

// ----------------------------------------------------------------------------
// Тема 6, задание 4. Служебная переменная с late
// ----------------------------------------------------------------------------
int heavyCalls = 0;

double heavyComputation() {
  heavyCalls++;
  print("  (выполняется тяжелое вычисление...)");
  double sum = 0;
  for (int i = 1; i <= 1000; i++) {
    sum += 1 / i;
  }
  return sum;
}

// Инициализатор late-переменной выполняется лениво — при первом чтении
late final double expensiveCalculation = heavyComputation();

void t6_4() {
  print("\n=== Тема 6, задание 4. Служебная переменная с late ===");
  print("До обращения вызовов: $heavyCalls");
  print("Первое чтение: ${expensiveCalculation.toStringAsFixed(4)}");
  print("Второе чтение: ${expensiveCalculation.toStringAsFixed(4)}");
  print("Всего вызовов вычисления: $heavyCalls");
}

// ----------------------------------------------------------------------------
// Тема 6, задание 5. Безопасный поиск в списке
// ----------------------------------------------------------------------------
// В Dart null-aware индексация записывается как ?[0] (а не ?.[0])
int firstOrMinusOne(List<int>? numbers) => numbers?[0] ?? -1;

// Вариант без риска RangeError для пустого списка (firstOrNull — Dart 3+)
int firstOrMinusOneSafe(List<int>? numbers) => numbers?.firstOrNull ?? -1;

void t6_5() {
  print("\n=== Тема 6, задание 5. Безопасный поиск в списке ===");
  print(firstOrMinusOne(null)); // -1
  print(firstOrMinusOne([7, 8, 9])); // 7
  print(firstOrMinusOneSafe(<int>[])); // -1
  print(firstOrMinusOneSafe([5])); // 5
}

// ----------------------------------------------------------------------------
// Задание 1. Калькулятор скидки с промокодом
// ----------------------------------------------------------------------------
double applyPromo(double orderTotal) {
  final discount = orderTotal * 0.15;
  final cappedDiscount = discount > 500 ? 500.0 : discount;
  return orderTotal - cappedDiscount;
}

void m01() {
  print("\n=== Задание 1. Калькулятор скидки с промокодом ===");
  for (final total in [1000.0, 3000.0, 10000.0]) {
    print("Заказ ${total.toStringAsFixed(2)} ₽ -> к оплате ${applyPromo(total).toStringAsFixed(2)} ₽");
  }
}

// ----------------------------------------------------------------------------
// Задание 2. Форматирование цены по стандарту валют
// ----------------------------------------------------------------------------
String formatPrice(double value) {
  final isNegative = value < 0;
  final fixed = value.abs().toStringAsFixed(2);
  final parts = fixed.split('.');
  final intPart = parts[0];
  final buffer = StringBuffer();
  for (int i = 0; i < intPart.length; i++) {
    if (i > 0 && (intPart.length - i) % 3 == 0) buffer.write(' ');
    buffer.write(intPart[i]);
  }
  return "${isNegative ? '-' : ''}$buffer.${parts[1]} ₽";
}

void m02() {
  print("\n=== Задание 2. Форматирование цены по стандарту валют ===");
  print(formatPrice(15400900.5)); // 15 400 900.50 ₽
  print(formatPrice(999.9));
  print(formatPrice(1000));
  print(formatPrice(0));
}

// ----------------------------------------------------------------------------
// Задание 3. Расчет кешбэка баллами
// ----------------------------------------------------------------------------
int cashbackPoints(int receiptRub) => receiptRub ~/ 100;

void m03() {
  print("\n=== Задание 3. Расчет кешбэка баллами ===");
  for (final receipt in [99, 100, 250, 1999, 5000]) {
    print("Чек $receipt ₽ -> ${cashbackPoints(receipt)} баллов");
  }
}

// ----------------------------------------------------------------------------
// Задание 4. Ограничитель диапазона (Clamp)
// ----------------------------------------------------------------------------
double clampVolume(double volume) {
  if (volume < 0.0) return 0.0;
  if (volume > 1.0) return 1.0;
  return volume;
}

void m04() {
  print("\n=== Задание 4. Ограничитель диапазона (Clamp) ===");
  for (final v in [-0.5, 0.0, 0.42, 1.0, 1.7]) {
    print("$v -> ${clampVolume(v)}");
  }
  // Встроенный вариант: clamp возвращает num, поэтому нужно toDouble()
  print("Встроенный clamp: ${(1.7).clamp(0.0, 1.0).toDouble()}");
}

// ----------------------------------------------------------------------------
// Задание 5. Конвертер байтов в мегабайты
// ----------------------------------------------------------------------------
double bytesToMb(int bytes) {
  final mb = bytes / (1024 * 1024);
  return (mb * 10).round() / 10;
}

void m05() {
  print("\n=== Задание 5. Конвертер байтов в мегабайты ===");
  for (final b in [0, 524288, 1048576, 5242880, 123456789]) {
    print("$b байт = ${bytesToMb(b).toStringAsFixed(1)} МБ");
  }
}

// ----------------------------------------------------------------------------
// Задание 6. Вычисление процентного прогресса
// ----------------------------------------------------------------------------
double progress(int current, int total) {
  if (total <= 0) return 0.0;
  final value = current / total;
  if (value < 0.0) return 0.0;
  if (value > 1.0) return 1.0;
  return value;
}

void m06() {
  print("\n=== Задание 6. Вычисление процентного прогресса ===");
  print(progress(0, 5)); // 0.0
  print(progress(2, 5)); // 0.4
  print(progress(5, 5)); // 1.0
  print(progress(7, 5)); // 1.0 (ограничено)
  print(progress(1, 0)); // 0.0 (защита от деления на ноль)
}

// ----------------------------------------------------------------------------
// Задание 7. Округление до ближайшего десятка
// ----------------------------------------------------------------------------
int roundUpToTen(int number) => (number / 10).ceil() * 10;

void m07() {
  print("\n=== Задание 7. Округление до ближайшего десятка ===");
  for (final n in [0, 1, 10, 43, 50, 99, 101]) {
    print("$n -> ${roundUpToTen(n)}");
  }
}

// ----------------------------------------------------------------------------
// Задание 8. Калькулятор стоимости доставки
// ----------------------------------------------------------------------------
int deliveryCost(double km) {
  const base = 200;
  const perKm = 30;
  const freeKm = 5;
  final extraKm = km > freeKm ? (km - freeKm).ceil() : 0;
  return base + extraKm * perKm;
}

void m08() {
  print("\n=== Задание 8. Калькулятор стоимости доставки ===");
  for (final km in [2.0, 5.0, 5.1, 8.0, 12.5]) {
    print("$km км -> ${deliveryCost(km)} ₽");
  }
}

// ----------------------------------------------------------------------------
// Задание 9. Проверка делимости без остатка
// ----------------------------------------------------------------------------
bool isDividedIntoBlocks(int sizeBytes) => sizeBytes % 1024 == 0;

void m09() {
  print("\n=== Задание 9. Проверка делимости без остатка ===");
  for (final size in [1024, 4096, 5000, 10240, 1500]) {
    final blocks = size ~/ 1024;
    print("$size байт -> делится ровно: ${isDividedIntoBlocks(size)} (целых блоков: $blocks)");
  }
}

// ----------------------------------------------------------------------------
// Задание 10. Парсер диапазона цен
// ----------------------------------------------------------------------------
(int min, int max)? parsePriceRange(String input) {
  final numbers = RegExp(r'\d+').allMatches(input).map((m) => int.parse(m.group(0)!)).toList();
  if (numbers.length < 2) return null;
  return (numbers[0], numbers[1]);
}

void m10() {
  print("\n=== Задание 10. Парсер диапазона цен ===");
  final range = parsePriceRange("1500 - 4500 руб");
  if (range != null) {
    final (min, max) = range;
    print("Минимальная цена: $min, максимальная цена: $max");
  }
  print("Некорректная строка: ${parsePriceRange("цена договорная")}");
}

// ----------------------------------------------------------------------------
// Задание 11. Валидатор пароля на регулярных выражениях
// ----------------------------------------------------------------------------
bool isStrongPassword(String password) {
  // минимум 8 символов, хотя бы одна цифра и одна заглавная буква
  final regex = RegExp(r'^(?=.*\d)(?=.*[A-ZА-ЯЁ]).{8,}$');
  return regex.hasMatch(password);
}

void m11() {
  print("\n=== Задание 11. Валидатор пароля на регулярных выражениях ===");
  for (final p in ["Flutter2024", "flutter2024", "Flutter", "FLUTTERRR", "Short1A", "Пароль123"]) {
    print("$p -> ${isStrongPassword(p)}");
  }
}

// ----------------------------------------------------------------------------
// Задание 12. Очистка поискового ввода
// ----------------------------------------------------------------------------
String cleanSearchQuery(String input) {
  return input
      .replaceAll(RegExp(r'[#$%]'), '')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim()
      .toLowerCase();
}

void m12() {
  print("\n=== Задание 12. Очистка поискового ввода ===");
  print("\"${cleanSearchQuery("  Купить   #Телефон  \$Apple  100%  ")}\"");
  print("\"${cleanSearchQuery("FLUTTER   Dart")}\"");
}

// ----------------------------------------------------------------------------
// Задание 13. Генератор сокращенного имени автора
// ----------------------------------------------------------------------------
String shortName(String fullName) {
  final parts = fullName.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
  if (parts.isEmpty) return "";
  final initials = parts.skip(1).map((p) => "${p[0].toUpperCase()}.");
  return [parts.first, ...initials].join(" ");
}

void m13() {
  print("\n=== Задание 13. Генератор сокращенного имени автора ===");
  print(shortName("Иванов Иван Иванович")); // Иванов И. И.
  print(shortName("Пушкин Александр"));
  print(shortName("Гоголь"));
}

// ----------------------------------------------------------------------------
// Задание 14. Парсинг HEX-цвета для Flutter
// ----------------------------------------------------------------------------
int parseHexColor(String hex) {
  var value = hex.trim().replaceFirst('#', '');
  if (value.length == 6) value = "FF$value"; // добавляем полную непрозрачность
  return int.parse(value, radix: 16);
}

void m14() {
  print("\n=== Задание 14. Парсинг HEX-цвета для Flutter ===");
  final color = parseHexColor("#FF5722");
  print("Цвет: 0x${color.toRadixString(16).toUpperCase()} (десятичное: $color)");
  final withAlpha = parseHexColor("#80FF5722");
  print("С прозрачностью: 0x${withAlpha.toRadixString(16).toUpperCase()}");
}

// ----------------------------------------------------------------------------
// Задание 15. Форматирование таймера звонка
// ----------------------------------------------------------------------------
String formatTimer(int seconds) {
  final minutes = seconds ~/ 60;
  final rest = seconds % 60;
  return "${minutes.toString().padLeft(2, '0')}:${rest.toString().padLeft(2, '0')}";
}

void m15() {
  print("\n=== Задание 15. Форматирование таймера звонка ===");
  for (final s in [0, 5, 59, 60, 125, 3599]) {
    print("$s с -> ${formatTimer(s)}");
  }
}

// ----------------------------------------------------------------------------
// Задание 16. Скрытие номера телефона
// ----------------------------------------------------------------------------
String maskPhone(String phone) {
  if (!RegExp(r'^\+7\d{10}$').hasMatch(phone)) return phone;
  return "+7 (${phone.substring(2, 5)}) ***-**-${phone.substring(10)}";
}

void m16() {
  print("\n=== Задание 16. Скрытие номера телефона ===");
  print(maskPhone("+79991234567")); // +7 (999) ***-**-67
  print(maskPhone("12345"));
}

// ----------------------------------------------------------------------------
// Задание 17. Определитель языка текста (Кириллица/Латиница)
// ----------------------------------------------------------------------------
bool hasCyrillic(String text) {
  return text.runes.any((r) => (r >= 0x0400 && r <= 0x04FF));
}

bool hasLatin(String text) {
  return text.runes.any((r) => (r >= 0x41 && r <= 0x5A) || (r >= 0x61 && r <= 0x7A));
}

String detectAlphabet(String text) {
  final cyr = hasCyrillic(text);
  final lat = hasLatin(text);
  if (cyr && lat) return "смешанный";
  if (cyr) return "кириллица";
  if (lat) return "латиница";
  return "нет букв";
}

void m17() {
  print("\n=== Задание 17. Определитель языка текста (Кириллица/Латиница) ===");
  for (final t in ["Привет, мир", "Hello, world", "Flutter и Dart", "12345 !?"]) {
    print("\"$t\" -> ${detectAlphabet(t)}");
  }
}

// ----------------------------------------------------------------------------
// Задание 18. Генератор слага (Slugify)
// ----------------------------------------------------------------------------
const Map<String, String> translitTable = {
  'а': 'a', 'б': 'b', 'в': 'v', 'г': 'g', 'д': 'd', 'е': 'e', 'ё': 'e',
  'ж': 'zh', 'з': 'z', 'и': 'i', 'й': 'i', 'к': 'k', 'л': 'l', 'м': 'm',
  'н': 'n', 'о': 'o', 'п': 'p', 'р': 'r', 'с': 's', 'т': 't', 'у': 'u',
  'ф': 'f', 'х': 'kh', 'ц': 'ts', 'ч': 'ch', 'ш': 'sh', 'щ': 'shch',
  'ъ': '', 'ы': 'y', 'ь': '', 'э': 'e', 'ю': 'yu', 'я': 'ya',
};

String slugify(String title) {
  final buffer = StringBuffer();
  for (final ch in title.toLowerCase().split('')) {
    buffer.write(translitTable[ch] ?? ch);
  }
  return buffer
      .toString()
      .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
      .replaceAll(RegExp(r'^-+|-+$'), '');
}

void m18() {
  print("\n=== Задание 18. Генератор слага (Slugify) ===");
  print(slugify("Быстрый старт во Flutter!")); // bystryi-start-vo-flutter
  print(slugify("  Dart 3: Records & Patterns  "));
}

// ----------------------------------------------------------------------------
// Задание 19. Подсчет слов в заметке
// ----------------------------------------------------------------------------
int countWordsInNote(String note) {
  return note.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty).length;
}

void m19() {
  print("\n=== Задание 19. Подсчет слов в заметке ===");
  const note = "Купить молоко\nпозвонить маме   и\n\nзаписаться к врачу";
  print("Слов в заметке: ${countWordsInNote(note)}");
  print("Пустая заметка: ${countWordsInNote("   ")}");
}

// ----------------------------------------------------------------------------
// Задание 20. Выделение тегов из текста
// ----------------------------------------------------------------------------
List<String> extractHashtags(String message) {
  return RegExp(r'#[\p{L}\p{N}_]+', unicode: true)
      .allMatches(message)
      .map((m) => m.group(0)!)
      .toList();
}

void m20() {
  print("\n=== Задание 20. Выделение тегов из текста ===");
  const post = "Сегодня изучаю #Flutter и #Dart! Отличный день для #мобильная_разработка.";
  print(extractHashtags(post));
}

// ----------------------------------------------------------------------------
// Задание 21. Фильтр каталога по диапазону цен
// ----------------------------------------------------------------------------
class Product21 {
  final String name;
  final double price;
  const Product21(this.name, this.price);

  @override
  String toString() => "$name (${price.toStringAsFixed(0)} ₽)";
}

List<Product21> filterByPrice(List<Product21> items, double min, double max) {
  return items.where((p) => p.price >= min && p.price <= max).toList();
}

void m21() {
  print("\n=== Задание 21. Фильтр каталога по диапазону цен ===");
  const catalog = [
    Product21("Мышь", 1200),
    Product21("Клавиатура", 3500),
    Product21("Монитор", 18000),
    Product21("Наушники", 4800),
  ];
  print("От 1000 до 5000: ${filterByPrice(catalog, 1000, 5000)}");
}

// ----------------------------------------------------------------------------
// Задание 22. Удаление завершенных задач из To-Do списка
// ----------------------------------------------------------------------------
class TodoTask22 {
  final String title;
  final bool isCompleted;
  const TodoTask22(this.title, this.isCompleted);

  @override
  String toString() => title;
}

void m22() {
  print("\n=== Задание 22. Удаление завершенных задач из To-Do списка ===");
  final tasks = [
    const TodoTask22("Купить хлеб", true),
    const TodoTask22("Сделать практическую", false),
    const TodoTask22("Позвонить маме", false),
    const TodoTask22("Оплатить интернет", true),
  ];
  final active = tasks.where((t) => t.isCompleted == false).toList();
  print("Активные задачи: $active");

  // Вариант с изменением исходного списка
  tasks.removeWhere((t) => t.isCompleted);
  print("После removeWhere: $tasks");
}

// ----------------------------------------------------------------------------
// Задание 23. Инверсия порядка чатов
// ----------------------------------------------------------------------------
void m23() {
  print("\n=== Задание 23. Инверсия порядка чатов ===");
  final messages = ["Привет", "Как дела?", "Всё хорошо", "Отлично!"];

  // reversed возвращает ленивый Iterable-вид без копирования списка
  final Iterable<String> reversedView = messages.reversed;

  for (final m in reversedView) {
    print(m);
  }
  print("Исходный список не изменился: $messages");
}

// ----------------------------------------------------------------------------
// Задание 24. Склейка двух списков баннеров
// ----------------------------------------------------------------------------
void m24() {
  print("\n=== Задание 24. Склейка двух списков баннеров ===");
  final systemPromos = ["Скидки недели", "Бесплатная доставка"];
  final personalOffers = ["Кешбэк 10% на электронику", "Подарок за отзыв"];

  final banners = [...systemPromos, ...personalOffers];
  print(banners);

  // Spread с проверкой на null
  List<String>? maybeOffers;
  print([...systemPromos, ...?maybeOffers]);
}

// ----------------------------------------------------------------------------
// Задание 25. Поиск максимального элемента без библиотек
// ----------------------------------------------------------------------------
class Product25 {
  final String name;
  final double rating;
  const Product25(this.name, this.rating);

  @override
  String toString() => "$name ($rating)";
}

void m25() {
  print("\n=== Задание 25. Поиск максимального элемента без библиотек ===");
  const products = [
    Product25("Чайник", 4.3),
    Product25("Блендер", 4.8),
    Product25("Тостер", 3.9),
  ];
  final best = products.reduce((a, b) => a.rating >= b.rating ? a : b);
  print("Лучший товар: $best");
}

// ----------------------------------------------------------------------------
// Задание 26. Чередование элементов списка
// ----------------------------------------------------------------------------
List<String> insertAds(List<String> feed, String ad, {int every = 5}) {
  final result = <String>[];
  for (int i = 0; i < feed.length; i++) {
    result.add(feed[i]);
    final isLast = i == feed.length - 1;
    if ((i + 1) % every == 0 && !isLast) {
      result.add(ad);
    }
  }
  return result;
}

void m26() {
  print("\n=== Задание 26. Чередование элементов списка ===");
  final news = List.generate(12, (i) => "Новость ${i + 1}");
  for (final line in insertAds(news, "[РЕКЛАМА]")) {
    print(line);
  }
}

// ----------------------------------------------------------------------------
// Задание 27. Проверка идентичности двух списков
// ----------------------------------------------------------------------------
bool listsEqual<T>(List<T> a, List<T> b) {
  if (a.length != b.length) return false;
  for (int i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}

void m27() {
  print("\n=== Задание 27. Проверка идентичности двух списков ===");
  print(listsEqual([1, 2, 3], [1, 2, 3])); // true
  print(listsEqual([1, 2, 3], [3, 2, 1])); // false
  print(listsEqual(["a"], ["a", "b"])); // false
  print(listsEqual<int>([], [])); // true
}

// ----------------------------------------------------------------------------
// Задание 28. Извлечение уникальных категорий
// ----------------------------------------------------------------------------
class Product28 {
  final String name;
  final String category;
  const Product28(this.name, this.category);
}

void m28() {
  print("\n=== Задание 28. Извлечение уникальных категорий ===");
  const products = [
    Product28("Футболка", "Одежда"),
    Product28("Ноутбук", "Электроника"),
    Product28("Джинсы", "Одежда"),
    Product28("Книга", "Книги"),
    Product28("Смартфон", "Электроника"),
  ];
  final List<String> categories = products.map((p) => p.category).toSet().toList();
  print("Категории: $categories");
}

// ----------------------------------------------------------------------------
// Задание 29. Сортировка списка по нескольким полям
// ----------------------------------------------------------------------------
class Product29 {
  final String name;
  final bool inStock;
  final double price;
  const Product29(this.name, this.inStock, this.price);

  @override
  String toString() => "$name | ${inStock ? 'в наличии' : 'нет'} | ${price.toStringAsFixed(0)} ₽";
}

void m29() {
  print("\n=== Задание 29. Сортировка списка по нескольким полям ===");
  final products = [
    const Product29("Планшет", false, 25000),
    const Product29("Чехол", true, 800),
    const Product29("Смартфон", true, 30000),
    const Product29("Зарядка", true, 1200),
    const Product29("Колонка", false, 5000),
  ];

  products.sort((a, b) {
    if (a.inStock != b.inStock) return a.inStock ? -1 : 1; // сначала в наличии
    return a.price.compareTo(b.price); // затем по возрастанию цены
  });

  for (final p in products) {
    print(p);
  }
}

// ----------------------------------------------------------------------------
// Задание 30. Постраничная группировка (Chunking)
// ----------------------------------------------------------------------------
List<List<T>> chunk<T>(List<T> list, int size) {
  final pages = <List<T>>[];
  for (int i = 0; i < list.length; i += size) {
    final end = i + size > list.length ? list.length : i + size;
    pages.add(list.sublist(i, end));
  }
  return pages;
}

void m30() {
  print("\n=== Задание 30. Постраничная группировка (Chunking) ===");
  final items = List.generate(100, (i) => i + 1);
  final pages = chunk(items, 10);
  print("Страниц: ${pages.length}");
  print("Первая страница: ${pages.first}");
  print("Последняя страница: ${pages.last}");
}

// ----------------------------------------------------------------------------
// Задание 31. Десериализация профиля
// ----------------------------------------------------------------------------
({int id, String name, int age, String email, bool isPremium}) parseProfile(
  Map<String, dynamic> json,
) {
  return (
    id: json["id"] as int? ?? 0,
    name: json["name"] as String? ?? "Гость",
    age: (json["age"] as num?)?.toInt() ?? 0,
    email: json["email"] as String? ?? "не указан",
    isPremium: json["isPremium"] as bool? ?? false,
  );
}

void m31() {
  print("\n=== Задание 31. Десериализация профиля ===");
  final full = <String, dynamic>{
    "id": 7,
    "name": "Мария",
    "age": 28,
    "email": "maria@example.com",
    "isPremium": true,
  };
  final partial = <String, dynamic>{"id": 8, "age": 31.0};

  print(parseProfile(full));
  print(parseProfile(partial));
  print(parseProfile({}));
}

// ----------------------------------------------------------------------------
// Задание 32. Конвертация списка в ассоциативную карту
// ----------------------------------------------------------------------------
class User32 {
  final int id;
  final String name;
  const User32(this.id, this.name);

  @override
  String toString() => "User($id, $name)";
}

void m32() {
  print("\n=== Задание 32. Конвертация списка в ассоциативную карту ===");
  const users = [User32(1, "Анна"), User32(2, "Борис"), User32(3, "Вера")];

  final Map<int, User32> byId = {for (final u in users) u.id: u};
  print(byId);
  print("Пользователь с id=2: ${byId[2]}");
  print("Пользователь с id=9: ${byId[9]}");
}

// ----------------------------------------------------------------------------
// Задание 33. Слияние локального и серверного профиля
// ----------------------------------------------------------------------------
void m33() {
  print("\n=== Задание 33. Слияние локального и серверного профиля ===");
  final cached = <String, dynamic>{"theme": "light", "language": "ru", "fontSize": 14};
  final server = <String, dynamic>{"theme": "dark", "notifications": true};

  // Ключи справа перезаписывают одноименные ключи слева
  final merged = {...cached, ...server};
  print(merged);

  // Эквивалент через addAll
  final copy = Map<String, dynamic>.from(cached)..addAll(server);
  print(copy);
}

// ----------------------------------------------------------------------------
// Задание 34. Удаление ключей с null-значениями
// ----------------------------------------------------------------------------
void m34() {
  print("\n=== Задание 34. Удаление ключей с null-значениями ===");
  final payload = <String, dynamic>{
    "name": "Алексей",
    "phone": null,
    "email": "a@mail.ru",
    "avatar": null,
    "age": 25,
  };

  final cleaned = Map<String, dynamic>.from(payload)..removeWhere((key, value) => value == null);
  print("Исходная карта: $payload");
  print("Для отправки: $cleaned");
}

// ----------------------------------------------------------------------------
// Задание 35. Кэш экранов (LRU-концепт)
// ----------------------------------------------------------------------------
class PageCache35 {
  final int capacity;
  final Map<String, String> _pages = {}; // Map в Dart хранит порядок вставки

  PageCache35(this.capacity);

  void open(String route, String title) {
    _pages.remove(route); // если страница уже была — переносим в конец
    _pages[route] = title;
    if (_pages.length > capacity) {
      final oldest = _pages.keys.first;
      _pages.remove(oldest);
      print("  Удалена из кэша: $oldest");
    }
  }

  List<String> get routes => _pages.keys.toList();
}

void m35() {
  print("\n=== Задание 35. Кэш экранов (LRU-концепт) ===");
  final cache = PageCache35(5);
  for (final r in ["/home", "/catalog", "/cart", "/profile", "/settings", "/catalog", "/about", "/help"]) {
    print("Открыта $r");
    cache.open(r, "Экран $r");
  }
  print("В кэше: ${cache.routes}");
}

// ----------------------------------------------------------------------------
// Задание 36. Инверсия карты
// ----------------------------------------------------------------------------
Map<String, String>? invertMap(Map<String, String> source) {
  // Инверсия возможна, только если значения уникальны
  if (source.values.toSet().length != source.length) return null;
  return {for (final e in source.entries) e.value: e.key};
}

void m36() {
  print("\n=== Задание 36. Инверсия карты ===");
  print(invertMap({"ru": "Россия", "de": "Германия", "fr": "Франция"}));
  print(invertMap({"a": "один", "b": "один"})); // null: значения повторяются
}

// ----------------------------------------------------------------------------
// Задание 37. Подсчет суммы товаров по категориям
// ----------------------------------------------------------------------------
Map<String, double> totalsByCategory(
  List<({String name, String category, double price, int qty})> purchases,
) {
  final totals = <String, double>{};
  for (final p in purchases) {
    final sum = p.price * p.qty;
    totals.update(p.category, (old) => old + sum, ifAbsent: () => sum);
  }
  return totals;
}

void m37() {
  print("\n=== Задание 37. Подсчет суммы товаров по категориям ===");
  final purchases = <({String name, String category, double price, int qty})>[
    (name: "Хлеб", category: "Еда", price: 50.0, qty: 2),
    (name: "Молоко", category: "Еда", price: 90.5, qty: 1),
    (name: "Футболка", category: "Одежда", price: 1200.0, qty: 1),
    (name: "Кабель", category: "Электроника", price: 350.0, qty: 3),
  ];
  totalsByCategory(purchases).forEach((cat, sum) {
    print("$cat: ${sum.toStringAsFixed(2)} ₽");
  });
}

// ----------------------------------------------------------------------------
// Задание 38. Валидация обязательных JSON-полей
// ----------------------------------------------------------------------------
List<String> missingKeys(Map<String, dynamic> json, List<String> requiredKeys) {
  return requiredKeys.where((k) => !json.containsKey(k)).toList();
}

void m38() {
  print("\n=== Задание 38. Валидация обязательных JSON-полей ===");
  const requiredKeys = ["status", "data", "timestamp"];
  final ok = <String, dynamic>{"status": "ok", "data": [], "timestamp": 1700000000};
  final bad = <String, dynamic>{"status": "ok"};

  for (final json in [ok, bad]) {
    final missing = missingKeys(json, requiredKeys);
    print(missing.isEmpty ? "Ответ валиден" : "Отсутствуют поля: $missing");
  }
  print("Через every: ${requiredKeys.every(ok.containsKey)}");
}

// ----------------------------------------------------------------------------
// Задание 39. Построение дерева категорий
// ----------------------------------------------------------------------------
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

void m39() {
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

// ----------------------------------------------------------------------------
// Задание 40. Сериализация параметров фильтра в URL
// ----------------------------------------------------------------------------
String toQueryString(Map<String, dynamic> params) {
  return params.entries
      .where((e) => e.value != null)
      .map((e) => "${Uri.encodeQueryComponent(e.key)}=${Uri.encodeQueryComponent(e.value.toString())}")
      .join("&");
}

void m40() {
  print("\n=== Задание 40. Сериализация параметров фильтра в URL ===");
  print(toQueryString({"brand": "Apple", "minPrice": 50000})); // brand=Apple&minPrice=50000
  print(toQueryString({"q": "умные часы", "inStock": true, "sort": null}));
}

// ----------------------------------------------------------------------------
// Задание 41. Парсер геолокации через Record
// ----------------------------------------------------------------------------
(double lat, double lon)? parseCoordinates(String input) {
  final parts = input.split(',');
  if (parts.length != 2) return null;
  final lat = double.tryParse(parts[0].trim());
  final lon = double.tryParse(parts[1].trim());
  if (lat == null || lon == null) return null;
  if (lat < -90 || lat > 90 || lon < -180 || lon > 180) return null;
  return (lat, lon);
}

void m41() {
  print("\n=== Задание 41. Парсер геолокации через Record ===");
  for (final s in ["54.01, 38.29", "91, 10", "abc, 10", "54.01"]) {
    final coords = parseCoordinates(s);
    if (coords != null) {
      final (lat, lon) = coords;
      print("\"$s\" -> широта $lat, долгота $lon");
    } else {
      print("\"$s\" -> некорректные координаты (null)");
    }
  }
}

// ----------------------------------------------------------------------------
// Задание 42. Резолвер состояний загрузки (Pattern Matching)
// ----------------------------------------------------------------------------
String resolveState(bool isLoading, bool hasError) {
  return switch ((isLoading: isLoading, hasError: hasError)) {
    (isLoading: true, hasError: false) => "Загрузка...",
    (isLoading: false, hasError: true) => "Произошла ошибка. Повторите попытку",
    (isLoading: false, hasError: false) => "Данные успешно загружены",
    (isLoading: true, hasError: true) => "Повторная загрузка после ошибки...",
  };
}

void m42() {
  print("\n=== Задание 42. Резолвер состояний загрузки (Pattern Matching) ===");
  print(resolveState(true, false));
  print(resolveState(false, true));
  print(resolveState(false, false));
  print(resolveState(true, true));
}

// ----------------------------------------------------------------------------
// Задание 43. Безопасная цепочка вызовов (Deep Null Traversal)
// ----------------------------------------------------------------------------
class Address43 {
  final String? street;
  const Address43(this.street);
}

class Company43 {
  final Address43? address;
  const Company43(this.address);
}

class User43 {
  final Company43? company;
  const User43(this.company);
}

String readStreet(User43? user) {
  return user?.company?.address?.street ?? "Адрес не указан";
}

void m43() {
  print("\n=== Задание 43. Безопасная цепочка вызовов (Deep Null Traversal) ===");
  print(readStreet(const User43(Company43(Address43("ул. Ленина, 5")))));
  print(readStreet(const User43(Company43(null))));
  print(readStreet(const User43(null)));
  print(readStreet(null));
}

// ----------------------------------------------------------------------------
// Задание 44. Сопоставление типа ответа API
// ----------------------------------------------------------------------------
String handleResponse(Object? response) {
  return switch (response) {
    int code => "Код ответа: $code",
    String error => "Ошибка: $error",
    Map data => "Данные (${data.length} полей): $data",
    null => "Пустой ответ",
    _ => "Неизвестный тип: ${response.runtimeType}",
  };
}

void m44() {
  print("\n=== Задание 44. Сопоставление типа ответа API ===");
  print(handleResponse(200));
  print(handleResponse("Таймаут соединения"));
  print(handleResponse({"id": 1, "name": "Тест"}));
  print(handleResponse(null));
  print(handleResponse(3.14));
}

// ----------------------------------------------------------------------------
// Задание 45. Деструктуризация координат точки в цикле
// ----------------------------------------------------------------------------
void m45() {
  print("\n=== Задание 45. Деструктуризация координат точки в цикле ===");
  final List<(int x, int y)> points = [(0, 0), (3, 4), (-2, 5)];

  for (var (x, y) in points) {
    final distanceSquared = x * x + y * y;
    print("Точка ($x, $y), квадрат расстояния до начала координат: $distanceSquared");
  }
}

// ----------------------------------------------------------------------------
// Задание 46. Обмен значений двух переменных без третьей
// ----------------------------------------------------------------------------
void m46() {
  print("\n=== Задание 46. Обмен значений двух переменных без третьей ===");
  var a = 10;
  var b = 20;
  print("До обмена: a = $a, b = $b");

  (a, b) = (b, a);
  print("После обмена: a = $a, b = $b");

  var first = "Первый";
  var second = "Второй";
  (first, second) = (second, first);
  print("Строки: $first, $second");
}

// ----------------------------------------------------------------------------
// Задание 47. Валидатор комплексной формы регистрации
// ----------------------------------------------------------------------------
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

void m47() {
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

// ----------------------------------------------------------------------------
// Задание 48. Обработка диапазона громкости через Switch Guard
// ----------------------------------------------------------------------------
String volumeMessage(int volume) {
  return switch (volume) {
    int v when v < 0 || v > 100 => "Некорректное значение: $v",
    int v when v > 80 => "Слишком громко!",
    int v when v == 0 => "Звук выключен",
    int v when v < 20 => "Тихо",
    _ => "Комфортная громкость",
  };
}

void m48() {
  print("\n=== Задание 48. Обработка диапазона громкости через Switch Guard ===");
  for (final v in [-5, 0, 10, 50, 85, 120]) {
    print("$v -> ${volumeMessage(v)}");
  }
}

// ----------------------------------------------------------------------------
// Задание 49. Пайплайн очистки телефонной книги
// ----------------------------------------------------------------------------
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
      continue; // номер неподходящей длины — пропускаем
    }
    result.add("+$normalized");
  }
  return result;
}

void m49() {
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

// ----------------------------------------------------------------------------
// Задание 50. Итоговый аналитический модуль корзины
// ----------------------------------------------------------------------------
({double total, double discountAmount, bool isFreeDelivery}) analyzeCart(
  List<Map<String, dynamic>> cart,
) {
  double total = 0;
  double discountAmount = 0;

  for (final item in cart) {
    final price = (item["price"] as num).toDouble();
    final qty = (item["qty"] as num?)?.toInt() ?? 1;
    final discountPercent = (item["discount"] as num?)?.toDouble() ?? 0.0;

    final gross = price * qty;
    final discount = gross * discountPercent / 100;

    discountAmount += discount;
    total += gross - discount;
  }

  return (total: total, discountAmount: discountAmount, isFreeDelivery: total >= 2000);
}

Set<String> extractCategories(List<Map<String, dynamic>> cart) {
  return cart.map((item) => item["category"] as String? ?? "Без категории").toSet();
}

void m50() {
  print("\n=== Задание 50. Итоговый аналитический модуль корзины ===");
  final cart = <Map<String, dynamic>>[
    {"name": "Чехол для телефона", "category": "Аксессуары", "price": 500, "qty": 2, "discount": 10},
    {"name": "Наушники", "category": "Электроника", "price": 1500.0, "qty": 1},
    {"name": "Кабель USB-C", "category": "Аксессуары", "price": 300, "qty": 1, "discount": 0},
  ];

  final result = analyzeCart(cart);
  print("Категории: ${extractCategories(cart)}");
  print("Итого к оплате: ${result.total.toStringAsFixed(2)} ₽");
  print("Сумма скидок: ${result.discountAmount.toStringAsFixed(2)} ₽");
  print("Бесплатная доставка: ${result.isFreeDelivery ? "да" : "нет"}");

  final small = analyzeCart([
    {"name": "Ручка", "category": "Канцелярия", "price": 50, "qty": 3},
  ]);
  print("Малая корзина: $small");
}


