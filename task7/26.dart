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

void main() {
  print("\n=== Задание 26. Чередование элементов списка ===");
  final news = List.generate(12, (i) => "Новость ${i + 1}");
  for (final line in insertAds(news, "[РЕКЛАМА]")) {
    print(line);
  }
}
