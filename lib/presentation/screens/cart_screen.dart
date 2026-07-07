import 'package:e_commerce/presentation/data/cart_mock_data.dart';
import 'package:e_commerce/presentation/widgets/cart/cart_header.dart';
import 'package:e_commerce/presentation/widgets/cart/cart_item_card.dart';
import 'package:e_commerce/presentation/widgets/cart/cart_price_summary.dart';
import 'package:e_commerce/presentation/widgets/cart/promo_code_field.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  /// When `true`, hides the back button (e.g. embedded in bottom nav).
  final bool embedded;

  const CartScreen({super.key, this.embedded = false});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<CartLineItem> _items;
  late Map<String, int> _quantities;
  final _promoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _items = List<CartLineItem>.from(mockCartItems);
    _quantities = {for (final item in _items) item.id: 1};
  }

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  bool get _useDemoTotals =>
      _items.length == mockCartItems.length &&
      _items.every((item) => (_quantities[item.id] ?? 1) == 1);

  double get _subtotal =>
      _items.isEmpty ? 0 : (_useDemoTotals ? mockCartSubtotal : _computedSubtotal);

  double get _computedSubtotal {
    var sum = 0.0;
    for (final item in _items) {
      sum += item.price * (_quantities[item.id] ?? 1);
    }
    return sum;
  }

  double get _shipping =>
      _items.isEmpty ? 0 : mockCartShippingFee;

  double get _total =>
      _items.isEmpty ? 0 : (_useDemoTotals ? mockCartTotal : _subtotal + _shipping);

  void _increment(String id) {
    setState(() => _quantities[id] = (_quantities[id] ?? 1) + 1);
  }

  void _decrement(String id) {
    final current = _quantities[id] ?? 1;
    if (current > 1) {
      setState(() => _quantities[id] = current - 1);
    }
  }

  void _removeItem(String id) {
    setState(() {
      _items.removeWhere((item) => item.id == id);
      _quantities.remove(id);
    });
  }

  bool get _showBack =>
      !widget.embedded && (Navigator.canPop(context));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return ColoredBox(
      color: scheme.surface,
      child: SafeArea(
        child: Column(
          children: [
            CartHeader(showBackButton: _showBack),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: CartLayout.horizontalPadding,
                ),
                itemCount: _items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  final item = _items[index];
                  final qty = _quantities[item.id] ?? 1;
                  return CartItemCard(
                    item: item,
                    quantity: qty,
                    onDelete: () => _removeItem(item.id),
                    onDecrement: () => _decrement(item.id),
                    onIncrement: () => _increment(item.id),
                  );
                },
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(
                CartLayout.horizontalPadding,
                16,
                CartLayout.horizontalPadding,
                20,
              ),
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHigh,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: scheme.shadow.withValues(alpha: 0.06),
                    blurRadius: 12,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PromoCodeField(
                      controller: _promoController,
                      onApply: () {},
                    ),
                    const SizedBox(height: 20),
                    CartPriceSummary(
                      subtotal: _subtotal,
                      shippingFee: _shipping,
                      total: _total,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: CartLayout.checkoutButtonHeight,
                      child: FilledButton(
                        onPressed: _items.isEmpty ? null : () {},
                        style: FilledButton.styleFrom(
                          backgroundColor: scheme.primary,
                          foregroundColor: scheme.onPrimary,
                          disabledBackgroundColor:
                              scheme.onSurfaceVariant.withValues(alpha: 0.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Proceed To Payment',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: scheme.onPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
