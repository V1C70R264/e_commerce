import 'package:flutter/material.dart';

/// Layout tokens for the grocery home screen.
abstract final class HomeLayout {
  static const double horizontalPadding = 20;
  static const double headerHeight = 168;
  static const double searchBarHeight = 52;
  static const double searchBarRadius = 28;
  static const double categorySize = 64;
  static const double bannerHeight = 150;
  static const double bannerRadius = 20;
  static const double productCardWidth = 168;
  static const double productCardHeight = 220;
  static const double bottomNavHeight = 78;
  static const double centerFabSize = 58;
}

class HomeCategoryData {
  final String id;
  final String label;
  final String? imageUrl;
  final IconData? icon;
  final bool isAll;

  const HomeCategoryData({
    required this.id,
    required this.label,
    this.imageUrl,
    this.icon,
    this.isAll = false,
  });
}

class HomeOfferData {
  final String discount;
  final String subtitle;
  final String ctaLabel;
  final String imageUrl;

  const HomeOfferData({
    required this.discount,
    required this.subtitle,
    required this.ctaLabel,
    required this.imageUrl,
  });
}

class HomeProductItem {
  final String id;
  final String title;
  final String description;
  final double price;
  final String unit;
  final String imageUrl;

  const HomeProductItem({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.unit,
    required this.imageUrl,
  });
}

// const String kHomeUserName = user.name;
const String kHomeUserAvatar =
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&q=80';

final List<HomeCategoryData> homeCategories = [
  const HomeCategoryData(
    id: 'fruits',
    label: 'Fruits',
    icon: Icons.apple_rounded,
  ),
  const HomeCategoryData(
    id: 'vegetables',
    label: 'Vegetables',
    icon: Icons.eco_rounded,
  ),
  const HomeCategoryData(
    id: 'fish',
    label: 'Fishs',
    icon: Icons.set_meal_rounded,
  ),
  const HomeCategoryData(
    id: 'bread',
    label: 'Bread',
    icon: Icons.bakery_dining_rounded,
  ),
  const HomeCategoryData(
    id: 'coffee',
    label: 'Coffee',
    icon: Icons.local_cafe_rounded,
  ),
];

const HomeOfferData homeSpecialOffer = HomeOfferData(
  discount: '35% Discount',
  subtitle: '100% Guaranteed all Fresh Grocery Items',
  ctaLabel: 'Shop Now',
  imageUrl:
      'https://images.unsplash.com/photo-1590502593747-42a9968003fc?w=500&q=80',
);

final List<HomeProductItem> homePopularProducts = [
  const HomeProductItem(
    id: '1',
    title: 'Fresh Green Bean',
    description: 'Original fresh green bean',
    price: 25.00,
    unit: 'Kg',
    imageUrl:
        'https://images.unsplash.com/photo-1563565375-3a1c127875e0?w=400&q=80',
  ),
  const HomeProductItem(
    id: '2',
    title: 'Beef Boneless',
    description: 'Fresh beef boneless',
    price: 49.99,
    unit: 'Kg',
    imageUrl:
        'https://images.unsplash.com/photo-1607623814075-e51df1bdc82f?w=400&q=80',
  ),
  const HomeProductItem(
    id: '3',
    title: 'Organic Tomato',
    description: 'Farm fresh organic tomato',
    price: 18.50,
    unit: 'Kg',
    imageUrl:
        'https://images.unsplash.com/photo-1546094096-0df4bcaaa337?w=400&q=80',
  ),
  const HomeProductItem(
    id: '4',
    title: 'Fresh Strawberry',
    description: 'Sweet red strawberry',
    price: 32.00,
    unit: 'Kg',
    imageUrl:
        'https://images.unsplash.com/photo-1464965911861-746a04a4bca6?w=200&q=80',
  ),
];
