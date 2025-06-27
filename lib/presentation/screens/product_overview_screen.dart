import 'package:e_commerce/presentation/widgets/product_card.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class ProductOverviewScreen extends StatelessWidget {
  const ProductOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Replace with your actual state management (Cubit/Bloc/Provider)
    final isLoading =
        true; // Example: context.watch<ProductCubit>().state is ProductLoading
    final products = []; // Example: context.watch<ProductCubit>().products

    return Scaffold(
      appBar: AppBar(title: Text('Products')),
      body: isLoading
          ? ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  height: 100,
                  color: Colors.white,
                ),
              ),
            )
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) =>
                  ProductCard(product: products[index]),
            ),
    );
  }
}
