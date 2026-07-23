import 'package:flutter/material.dart';

class FavoriteProductItem {
  final String id;
  final String title;
  final String deliveryTime;
  final double rating;
  final double price;
  final String unit;
  final String imageUrl;

  const FavoriteProductItem({
    required this.id,
    required this.title,
    required this.deliveryTime,
    required this.rating,
    required this.price,
    required this.unit,
    required this.imageUrl,
  });
}

final List<FavoriteProductItem> favoriteProductsMock = [
  const FavoriteProductItem(
    id: '1',
    title: 'Strawberry',
    deliveryTime: '30mn',
    rating: 4.5,
    price: 8.99,
    unit: '1kg',
    imageUrl:
        'https://images.unsplash.com/photo-1464965911861-746a04a4bca6?w=400&q=80',
  ),
  const FavoriteProductItem(
    id: '2',
    title: 'Vagitable',
    deliveryTime: '50mn',
    rating: 4.9,
    price: 9.99,
    unit: '1kg',
    imageUrl:
        'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=400&q=80',
  ),
  const FavoriteProductItem(
    id: '3',
    title: 'Capsicum',
    deliveryTime: '30mn',
    rating: 4.5,
    price: 2.99,
    unit: '1kg',
    imageUrl:
        'https://images.unsplash.com/photo-1563565375-3a1c127875e0?w=400&q=80',
  ),
  const FavoriteProductItem(
    id: '4',
    title: 'Tomato',
    deliveryTime: '25mn',
    rating: 4.2,
    price: 2.99,
    unit: '1kg',
    imageUrl:
        'https://images.unsplash.com/photo-1546094096-0df4bcaaa337?w=400&q=80',
  ),
  const FavoriteProductItem(
    id: '5',
    title: 'Vegetables',
    deliveryTime: '10mn',
    rating: 4.9,
    price: 1.99,
    unit: '1kg',
    imageUrl:
        'https://images.unsplash.com/photo-1557844352-761f2565b576?w=400&q=80',
  ),
  const FavoriteProductItem(
    id: '6',
    title: 'Fruits',
    deliveryTime: '40mn',
    rating: 4.5,
    price: 22.99,
    unit: '1kg',
    imageUrl:
        'https://images.unsplash.com/photo-1619566636858-adf3ef46400b?w=400&q=80',
  ),
];

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;
    const primaryGreen = Color(0xFF26AD71);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Navigation Bar (Back Button & Notification Bell)
          Padding(
            padding: EdgeInsets.only(
              top: topPadding + 10,
              left: 20,
              right: 20,
              bottom: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back Button
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    shape: const CircleBorder(),
                    child: InkWell(
                      onTap: () {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      },
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: Color(0xFF0F172A),
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),

                // Notification Bell with Green Badge
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    shape: const CircleBorder(),
                    child: InkWell(
                      onTap: () {},
                      customBorder: const CircleBorder(),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const Icon(
                            Icons.notifications_rounded,
                            color: Color(0xFF0F172A),
                            size: 20,
                          ),
                          Positioned(
                            top: 9,
                            right: 10,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: primaryGreen,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Screen Title "Favourite"
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Text(
              'Favourite',
              style: TextStyle(
                color: Color(0xFF0F172A),
                fontSize: 24,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
              ),
            ),
          ),

          // 2-Column Product Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 4,
                bottom: 24,
              ),
              itemCount: favoriteProductsMock.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.72,
              ),
              itemBuilder: (context, index) {
                final item = favoriteProductsMock[index];
                return _FavoriteCard(item: item, primaryGreen: primaryGreen);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FavoriteCard extends StatelessWidget {
  final FavoriteProductItem item;
  final Color primaryGreen;

  const _FavoriteCard({
    required this.item,
    required this.primaryGreen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Card Content Column
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 8),

                // Product Image
                Expanded(
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        item.imageUrl,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.image_not_supported_rounded,
                          size: 40,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Product Title
                Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),

                // Subtitle Row: Delivery time & Rating
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.deliveryTime,
                      style: const TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.star_rounded,
                      color: Color(0xFFFFB800),
                      size: 15,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      item.rating.toStringAsFixed(1),
                      style: const TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                // Price Row
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '\$${item.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Color(0xFF0F172A),
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      TextSpan(
                        text: '/${item.unit}',
                        style: const TextStyle(
                          color: Color(0xFF94A3B8),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),

          // Top-Right Action Button (+)
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryGreen,
                boxShadow: [
                  BoxShadow(
                    color: primaryGreen.withValues(alpha: 0.35),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${item.title} added to cart'),
                        duration: const Duration(seconds: 1),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  customBorder: const CircleBorder(),
                  child: const Center(
                    child: Icon(
                      Icons.add_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
