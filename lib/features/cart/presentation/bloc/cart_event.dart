abstract class CartEvent {}

class LoadCart extends CartEvent {}

class IncreaseCartItem extends CartEvent {
  final int id;

  IncreaseCartItem(this.id);
}

class DecreaseCartItem extends CartEvent {
  final int id;

  DecreaseCartItem(this.id);
}

class RemoveCartItem extends CartEvent {
  final int id;

  RemoveCartItem(this.id);
}

class EditCart extends CartEvent {}

class DoneCart extends CartEvent {}