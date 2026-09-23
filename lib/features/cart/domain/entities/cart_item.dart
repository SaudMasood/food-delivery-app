class CartItem {
  final int id;
  final String name;
  final String image;
  final String size;
  final double price;
  final int quantity;

  const CartItem({
    required this.id,
    required this.name,
    required this.image,
    required this.size,
    required this.price,
    required this.quantity,
  });

  CartItem copyWith({
    int? quantity,
  }) {
    return CartItem(
      id: id,
      name: name,
      image: image,
      size: size,
      price: price,
      quantity: quantity ?? this.quantity,
    );
  }
}