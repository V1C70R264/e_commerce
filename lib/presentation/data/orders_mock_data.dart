/// Layout tokens for the orders screen.
abstract final class OrdersLayout {
  static const double horizontalPadding = 20;
  static const double cardRadius = 15;
  static const double orderImageSize = 88;
}

class OrderItemData {
  final String id;
  final String transactionId;
  final String scheduledDate;
  final String status;
  final double price;
  final String imageUrl;

  const OrderItemData({
    required this.id,
    required this.transactionId,
    required this.scheduledDate,
    required this.status,
    required this.price,
    required this.imageUrl,
  });
}

final List<OrderItemData> inProgressOrders = [
  const OrderItemData(
    id: '1',
    transactionId: 'A23B567K',
    scheduledDate: '22/09/2023',
    status: 'Out For Delivery',
    price: 265.00,
    imageUrl:
        'https://images.unsplash.com/photo-1604503468506-a8da358d5240?w=300&q=80',
  ),
  const OrderItemData(
    id: '2',
    transactionId: 'B45C789M',
    scheduledDate: '22/09/2023',
    status: 'Out For Delivery',
    price: 265.00,
    imageUrl:
        'https://images.unsplash.com/photo-1523049673857-9f1a6dccc969?w=300&q=80',
  ),
  const OrderItemData(
    id: '3',
    transactionId: 'C67D012N',
    scheduledDate: '22/09/2023',
    status: 'Out For Delivery',
    price: 265.00,
    imageUrl:
        'https://images.unsplash.com/photo-1587593819430-3aee1550b8c0?w=300&q=80',
  ),
];

final List<OrderItemData> completedOrders = [
  const OrderItemData(
    id: '4',
    transactionId: 'D89E234P',
    scheduledDate: '15/09/2023',
    status: 'Delivered',
    price: 320.00,
    imageUrl:
        'https://images.unsplash.com/photo-1615485925515-ef4e4b547ac8?w=300&q=80',
  ),
  const OrderItemData(
    id: '5',
    transactionId: 'E01F456Q',
    scheduledDate: '10/09/2023',
    status: 'Delivered',
    price: 189.50,
    imageUrl:
        'https://images.unsplash.com/photo-1607623814075-e51df1bdc82f?w=300&q=80',
  ),
];
