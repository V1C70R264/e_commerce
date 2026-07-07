import 'package:e_commerce/presentation/data/home_mock_data.dart';
import 'package:e_commerce/presentation/screens/cart_screen.dart';
import 'package:e_commerce/presentation/screens/favorites_screen.dart';
import 'package:e_commerce/presentation/screens/orders_screen.dart';
import 'package:e_commerce/presentation/screens/profile_screen.dart';
import 'package:e_commerce/presentation/widgets/home/category_item.dart';
import 'package:e_commerce/presentation/widgets/home/home_banner.dart';
import 'package:e_commerce/presentation/widgets/home/home_bottom_navigation.dart';
import 'package:e_commerce/presentation/widgets/home/home_header.dart';
import 'package:e_commerce/data/models/product_model.dart';
import 'package:e_commerce/presentation/screens/product_detail_screen.dart';
import 'package:e_commerce/presentation/widgets/home/product_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _navIndex = 0;
  String _selectedCategoryId = 'all';

  void _onNavTap(int index) {
    setState(() => _navIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final body = switch (_navIndex) {
      1 => const FavoritesScreen(),
      2 => const CartScreen(embedded: true),
      3 => const OrdersScreen(embedded: true),
      4 => ProfileScreen(),
      _ => _GroceryHomeBody(
          selectedCategoryId: _selectedCategoryId,
          onCategorySelected: (id) =>
              setState(() => _selectedCategoryId = id),
        ),
    };

    return Scaffold(
      body: body,
      bottomNavigationBar: HomeBottomNavigation(
        currentIndex: _navIndex,
        onTap: _onNavTap,
      ),
    );
  }
}

class _GroceryHomeBody extends StatelessWidget {
  final String selectedCategoryId;
  final ValueChanged<String> onCategorySelected;

  const _GroceryHomeBody({
    required this.selectedCategoryId,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return ColoredBox(
      color: scheme.surface,
      child: Column(
        children: [
          const HomeHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 100,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: HomeLayout.horizontalPadding,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: homeCategories.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        final category = homeCategories[index];
                        return CategoryItem(
                          category: category,
                          isSelected:
                              selectedCategoryId == category.id,
                          onTap: () => onCategorySelected(category.id),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: HomeLayout.horizontalPadding,
                    ),
                    child: Text(
                      'Special Offers',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: scheme.onSurface,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: HomeLayout.horizontalPadding,
                    ),
                    child: HomeBanner(offer: homeSpecialOffer),
                  ),
                  const SizedBox(height: 28),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: HomeLayout.horizontalPadding,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Popular Items',
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: scheme.onSurface,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            foregroundColor: scheme.onSurfaceVariant,
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'View All',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    height: HomeLayout.productCardHeight,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: HomeLayout.horizontalPadding,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: homePopularProducts.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(width: 14),
                      itemBuilder: (context, index) {
                        final item = homePopularProducts[index];
                        return ProductCard(
                          product: item,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProductDetailScreen(
                                  product: Product(
                                    id: item.id,
                                    title: item.title,
                                    description: item.description,
                                    imageUrl: item.imageUrl,
                                    price: item.price,
                                    category: ProductCategory.other,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
