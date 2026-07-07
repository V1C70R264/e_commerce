import 'package:flutter/material.dart';

class ProductDetailMetaRow extends StatelessWidget {
  final double rating;
  final int reviewCount;
  final String seller;
  final String vendor;

  const ProductDetailMetaRow({
    super.key,
    required this.rating,
    required this.reviewCount,
    required this.seller,
    required this.vendor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: scheme.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star, size: 14, color: scheme.onPrimary),
              const SizedBox(width: 4),
              Text(
                rating.toStringAsFixed(1),
                style: theme.textTheme.labelMedium?.copyWith(
                  color: scheme.onPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '($reviewCount Reviews)',
          style: theme.textTheme.bodySmall?.copyWith(
            color: scheme.onSurfaceVariant,
          ),
        ),
        _VerticalDivider(color: scheme.outlineVariant),
        Expanded(
          child: Text(
            'Seller: $seller',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              color: scheme.onSurface,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        _VerticalDivider(color: scheme.outlineVariant),
        Expanded(
          child: Text(
            'Vendor: $vendor',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              color: scheme.onSurface,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  final Color color;

  const _VerticalDivider({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 16,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      color: color,
    );
  }
}
