import 'package:e_commerce/presentation/data/product_detail_mock_data.dart';
import 'package:flutter/material.dart';

class ProductDetailImageHeader extends StatelessWidget {
  final String imageUrl;
  final VoidCallback? onBack;

  const ProductDetailImageHeader({
    super.key,
    required this.imageUrl,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: ProductDetailLayout.imageHeaderHeight +
          MediaQuery.paddingOf(context).top,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: scheme.surface,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(ProductDetailLayout.imageHeaderRadius),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.paddingOf(context).top + 56,
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Icon(
                      Icons.image_not_supported_outlined,
                      size: 64,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.paddingOf(context).top + 12,
            left: ProductDetailLayout.horizontalPadding,
            child: Material(
              color: scheme.surfaceContainerHigh,
              elevation: 4,
              shadowColor: scheme.shadow.withValues(alpha: 0.12),
              shape: const CircleBorder(),
              child: InkWell(
                onTap: onBack ?? () => Navigator.maybePop(context),
                customBorder: const CircleBorder(),
                child: SizedBox(
                  width: ProductDetailLayout.backButtonSize,
                  height: ProductDetailLayout.backButtonSize,
                  child: Icon(
                    Icons.chevron_left,
                    size: 28,
                    color: scheme.onSurface,
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
