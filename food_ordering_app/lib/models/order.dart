class Order {
  final int id;
  final String userId;
  final String status;
  final double totalAmount;
  final String deliveryName;
  final String deliveryPhone;
  final String deliveryRegion;
  final String deliveryCity;
  final String deliveryAddress;
  final String deliveryLandmark;
  final String paymentMethod;
  final DateTime createdAt;

  Order({
    required this.id,
    required this.userId,
    required this.status,
    required this.totalAmount,
    required this.deliveryName,
    required this.deliveryPhone,
    required this.deliveryRegion,
    required this.deliveryCity,
    required this.deliveryAddress,
    required this.deliveryLandmark,
    required this.paymentMethod,
    required this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json['id'],
        userId: json['user_id'],
        status: json['status'],
        totalAmount: (json['total_amount'] as num).toDouble(),
        deliveryName: json['delivery_name'],
        deliveryPhone: json['delivery_phone'],
        deliveryRegion: json['delivery_region'],
        deliveryCity: json['delivery_city'],
        deliveryAddress: json['delivery_address'],
        deliveryLandmark: json['delivery_landmark'],
        paymentMethod: json['payment_method'],
        createdAt: DateTime.parse(json['created_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'status': status,
        'total_amount': totalAmount,
        'delivery_name': deliveryName,
        'delivery_phone': deliveryPhone,
        'delivery_region': deliveryRegion,
        'delivery_city': deliveryCity,
        'delivery_address': deliveryAddress,
        'delivery_landmark': deliveryLandmark,
        'payment_method': paymentMethod,
        'created_at': createdAt.toIso8601String(),
      };
}
