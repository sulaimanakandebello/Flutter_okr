// lib/pages/product_watch_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';
import '../models/product.dart';
import 'product_page.dart';

class ProductWatchPage extends StatelessWidget {
  const ProductWatchPage({super.key, required this.productId});
  final String productId;

  @override
  Widget build(BuildContext context) {
    final app = context.read<AppState>();
    return StreamBuilder<Product>(
      stream: app.watchProduct(productId),
      builder: (context, snap) {
        if (snap.hasError) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(child: Text('Failed to load product: ${snap.error}')),
          );
        }
        if (!snap.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return ProductPage(product: snap.data!);
      },
    );
  }
}
