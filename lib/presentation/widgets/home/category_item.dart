import 'package:e_commerce/presentation/data/home_mock_data.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final HomeCategoryData category;
  final bool isSelected;
  final VoidCallback? onTap;

  const CategoryItem({
    super.key,
    required this.category,
    required this.isSelected,
    this.onTap,
  });

  Color _getIconColor(String id) {
    return switch (id) {
      'fruits' => const Color(0xFFEF4444),
      'vegetables' => const Color(0xFF10B981),
      'fish' => const Color(0xFFF97316),
      'bread' => const Color(0xFFEAB308),
      'coffee' => const Color(0xFF8B5CF6),
      _ => const Color(0xFF26AD71),
    };
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color(0xFF26AD71);
    final iconColor = isSelected ? Colors.white : _getIconColor(category.id);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(26),
          border: Border.all(
            color: isSelected
                ? primaryColor
                : const Color(0xFFE2E8F0),
            width: 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: primaryColor.withValues(alpha: 0.35),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (category.icon != null) ...[
              Icon(
                category.icon,
                color: iconColor,
                size: 18,
              ),
              const SizedBox(width: 8),
            ] else if (category.imageUrl != null) ...[
              ClipOval(
                child: Image.network(
                  category.imageUrl!,
                  width: 20,
                  height: 20,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Icon(
                    Icons.category,
                    color: iconColor,
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
            Text(
              category.label,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF475569),
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
