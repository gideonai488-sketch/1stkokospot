import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/order.dart';
import '../models/order_item.dart';

class OrderService {
  final SupabaseClient client;
  OrderService(this.client);

  Future<List<Order>> fetchOrders(String userId) async {
    final res = await client
        .from('orders')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);
    return (res as List).map((e) => Order.fromJson(e)).toList();
  }

  Future<Order> createOrder(Order order, List<OrderItem> items) async {
    final inserted = await client.from('orders').insert(order.toJson()).select().single();
    final orderId = inserted['id'] as int;
    for (final item in items) {
      await client.from('order_items').insert({...item.toJson(), 'order_id': orderId});
    }
    return Order.fromJson(inserted);
  }

  Future<List<OrderItem>> fetchOrderItems(int orderId) async {
    final res = await client
        .from('order_items')
        .select()
        .eq('order_id', orderId);
    return (res as List).map((e) => OrderItem.fromJson(e)).toList();
  }
}
