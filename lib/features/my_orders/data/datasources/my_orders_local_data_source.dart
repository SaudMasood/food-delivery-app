import '../models/order_model.dart';
import '../../domain/entities/order.dart';

class MyOrdersLocalDataSource {
  List<OrderModel> getOrders() {
    return [
      const OrderModel(
        id: 1,
        category: 'Food',
        restaurant: 'Pizza Hut',
        orderNumber: '#162432',
        price: 35.25,
        itemCount: 3,
        date: '29 JAN, 12:30',
        status: OrderStatus.ongoing,
        image: 'assets/images/pizza.png',
      ),
      const OrderModel(
        id: 2,
        category: 'Drink',
        restaurant: 'McDonald',
        orderNumber: '#242432',
        price: 40.15,
        itemCount: 2,
        date: '30 JAN, 12:30',
        status: OrderStatus.ongoing,
        image: 'assets/images/mcdonald.png',
      ),
      const OrderModel(
        id: 3,
        category: 'Drink',
        restaurant: 'Starbucks',
        orderNumber: '#240112',
        price: 10.20,
        itemCount: 1,
        date: '31 JAN, 12:30',
        status: OrderStatus.ongoing,
        image: 'assets/images/starbucks.png',
      ),
      const OrderModel(
        id: 4,
        category: 'Food',
        restaurant: 'Pizza Hut',
        orderNumber: '#162432',
        price: 35.25,
        itemCount: 3,
        date: '29 JAN, 12:30',
        status: OrderStatus.completed,
        image: 'assets/images/pizza.png',
      ),
      const OrderModel(
        id: 5,
        category: 'Drink',
        restaurant: 'McDonald',
        orderNumber: '#242432',
        price: 40.15,
        itemCount: 2,
        date: '30 JAN, 12:30',
        status: OrderStatus.completed,
        image: 'assets/images/mcdonald.png',
      ),
      const OrderModel(
        id: 6,
        category: 'Drink',
        restaurant: 'Starbucks',
        orderNumber: '#240112',
        price: 10.20,
        itemCount: 1,
        date: '31 JAN, 12:30',
        status: OrderStatus.canceled,
        image: 'assets/images/starbucks.png',
      ),
    ];
  }
}