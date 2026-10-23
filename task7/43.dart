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

void main() {
  print("\n=== Задание 43. Безопасная цепочка вызовов (Deep Null Traversal) ===");
  print(readStreet(const User43(Company43(Address43("ул. Ленина, 5")))));
  print(readStreet(const User43(Company43(null))));
  print(readStreet(const User43(null)));
  print(readStreet(null));
}
