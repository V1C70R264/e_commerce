import 'package:flutter/material.dart';

class OrdersHeader extends StatelessWidget {
  final bool showBackButton;
  final VoidCallback? onBack;

  const OrdersHeader({
    super.key,
    this.showBackButton = true,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (showBackButton)
            Align(
              alignment: Alignment.centerLeft,
              child: Material(
                color: scheme.surfaceContainerHigh,
                elevation: 4,
                shadowColor: scheme.shadow.withValues(alpha: 0.12),
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: onBack ?? () => Navigator.maybePop(context),
                  customBorder: const CircleBorder(),
                  child: SizedBox(
                    width: 44,
                    height: 44,
                    child: Icon(
                      Icons.chevron_left,
                      color: scheme.onSurface,
                      size: 28,
                    ),
                  ),
                ),
              ),
            ),
          Text(
            'My Orders',
            style: theme.textTheme.titleLarge?.copyWith(
              color: scheme.onSurface,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
