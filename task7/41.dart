(double lat, double lon)? parseCoordinates(String input) {
  final parts = input.split(',');
  if (parts.length != 2) return null;
  final lat = double.tryParse(parts[0].trim());
  final lon = double.tryParse(parts[1].trim());
  if (lat == null || lon == null) return null;
  if (lat < -90 || lat > 90 || lon < -180 || lon > 180) return null;
  return (lat, lon);
}

void main() {
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
