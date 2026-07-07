import 'package:flutter/material.dart';

class CartPriceSummary extends StatelessWidget {
  final double subtotal;
  final double shippingFee;
  final double total;

  const CartPriceSummary({
    super.key,
    required this.subtotal,
    required this.shippingFee,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Column(
      children: [
        _SummaryRow(
          label: 'Subtotal',
          value: '\$${subtotal.toStringAsFixed(2)}',
          labelStyle: theme.textTheme.bodyMedium?.copyWith(
            color: scheme.onSurfaceVariant,
          ),
          valueStyle: theme.textTheme.bodyLarge?.copyWith(
            color: scheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        _SummaryRow(
          label: 'Shipping Fee',
          value: '\$${shippingFee.toStringAsFixed(2)}',
          labelStyle: theme.textTheme.bodyMedium?.copyWith(
            color: scheme.onSurfaceVariant,
          ),
          valueStyle: theme.textTheme.bodyLarge?.copyWith(
            color: scheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 14),
        Divider(color: scheme.outlineVariant, height: 1),
        const SizedBox(height: 14),
        _SummaryRow(
          label: 'Total',
          value: '\$${total.toStringAsFixed(2)}',
          labelStyle: theme.textTheme.titleMedium?.copyWith(
            color: scheme.onSurface,
            fontWeight: FontWeight.w800,
          ),
          valueStyle: theme.textTheme.titleLarge?.copyWith(
            color: scheme.onSurface,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.labelStyle,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: labelStyle),
        Text(value, style: valueStyle),
      ],
    );
  }
}
