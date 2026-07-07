/// Layout tokens for the cart screen.
abstract final class CartLayout {
  static const double horizontalPadding = 20;
  static const double cardRadius = 20;
  static const double itemImageSize = 88;
  static const double promoFieldHeight = 56;
  static const double checkoutButtonHeight = 56;
}

class CartLineItem {
  final String id;
  final String title;
  final String subtitle;
  final double price;
  final String imageUrl;

  const CartLineItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.imageUrl,
  });
}

final List<CartLineItem> mockCartItems = [
  const CartLineItem(
    id: '1',
    title: 'Broiler Chicken Skin',
    subtitle: 'Fresh Chicken Skin',
    price: 265,
    imageUrl:
        'https://images.unsplash.com/photo-1604503468506-a8da358d5240?w=300&q=80',
  ),
  const CartLineItem(
    id: '2',
    title: 'Fresh Watermelon',
    subtitle: 'Fresh Watermelon',
    price: 265,
    imageUrl:
        'https://images.unsplash.com/photo-1523049673857-9f1a6dccc969?w=300&q=80',
  ),
  const CartLineItem(
    id: '3',
    title: 'Fresh Green bean',
    subtitle: 'Original Fresh Green Bean',
    price: 265,
    imageUrl:
        'https://images.unsplash.com/photo-1615485925515-ef4e4b547ac8?w=300&q=80',
  ),
];

const double mockCartSubtotal = 2510.00;
const double mockCartShippingFee = 30.00;
const double mockCartTotal = 2540.00;
