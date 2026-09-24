enum OrderStatus {
  ongoing,
  completed,
  canceled,
}

class Order {
  final int id;
  final String category;
  final String restaurant;
  final String orderNumber;
  final double price;
  final int itemCount;
  final String date;
  final OrderStatus status;
  final String image;

  const Order({
    required this.id,
    required this.category,
    required this.restaurant,
    required this.orderNumber,
    required this.price,
    required this.itemCount,
    required this.date,
    required this.status,
    required this.image,
  });
}