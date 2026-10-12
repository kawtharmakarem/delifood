class FoodItemData {
  final String image;
  final double x;
  final double y;
  final double rotation;
  final double size;

  FoodItemData({
    required this.image,
    required this.x,
    required this.y,
    required this.rotation,
    required this.size,
  });
}

class Sticker {
  final List<FoodItemData> items;

  Sticker({required this.items});
}

//login
class Customer {
  final String id;
  final String name;

  Customer({required this.id, required this.name});
}

class Contacts {
  final String phone;
  final String email;
  final String link;

  Contacts({required this.phone, required this.email, required this.link});
}

class Authentication {
  final Customer? customer;
  final Contacts? contacts;

  Authentication({required this.customer, required this.contacts});
}
