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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 72,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: HomeLayout.categorySize,
              height: HomeLayout.categorySize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? scheme.primary
                    : scheme.surfaceContainerHigh,
                boxShadow: isSelected
                    ? null
                    : [
                        BoxShadow(
                          color: scheme.shadow.withValues(alpha: 0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                image: category.isAll || category.imageUrl == null
                    ? null
                    : DecorationImage(
                        image: NetworkImage(category.imageUrl!),
                        fit: BoxFit.cover,
                      ),
              ),
              child: category.isAll
                  ? Icon(
                      Icons.menu,
                      color: isSelected
                          ? scheme.onPrimary
                          : scheme.onSurface,
                      size: 26,
                    )
                  : null,
            ),
            const SizedBox(height: 8),
            Text(
              category.label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.labelSmall?.copyWith(
                color: isSelected ? scheme.primary : scheme.onSurface,
                fontWeight:
                    isSelected ? FontWeight.w600 : FontWeight.w500,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
