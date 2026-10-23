void main() {
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
