import 'package:e_commerce/presentation/data/cart_mock_data.dart';
import 'package:flutter/material.dart';

class PromoCodeField extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback? onApply;

  const PromoCodeField({
    super.key,
    this.controller,
    this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Container(
      height: CartLayout.promoFieldHeight,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(CartLayout.promoFieldHeight / 2),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: scheme.onSurface,
              ),
              decoration: InputDecoration(
                hintText: 'Enter Promo Code',
                hintStyle: theme.textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
          Material(
            color: scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(22),
            child: InkWell(
              onTap: onApply,
              borderRadius: BorderRadius.circular(22),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                child: Text(
                  'Apply Code',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: scheme.onInverseSurface,
                    fontWeight: FontWeight.w600,
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
