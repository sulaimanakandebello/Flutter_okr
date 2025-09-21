import 'package:flutter/material.dart';
import 'package:flutter_okr/models/product.dart';

import 'app_shell.dart';
import 'pages/product_page.dart';
import 'pages/make_offer_page.dart';
import 'pages/checkout_page.dart';

// Route names in one place
abstract class AppRoutes {
  static const shell = '/';
  static const product = '/product';
  static const checkout = '/checkout';
  static const makeOffer = '/make-offer';
  static const sell = '/sell'; // optional direct
}

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.shell:
        return MaterialPageRoute(builder: (_) => const AppShell());

      case AppRoutes.product:
        final product = settings.arguments as Product;
        return MaterialPageRoute(builder: (_) => ProductPage(product: product));

      case AppRoutes.checkout:
        final product = settings.arguments as Product;
        return MaterialPageRoute(
          builder: (_) => CheckoutPage(product: product),
        );

      case AppRoutes.makeOffer:
        final a = settings.arguments as MakeOfferArgs;
        return MaterialPageRoute(
          builder: (_) => MakeOfferPage(
            productTitle: a.title,
            productPrice: a.price,
            thumbUrl: a.thumbUrl,
          ),
        );

      // optional direct sell entry
      case AppRoutes.sell:
        // import only if you want deep-link to sell
        // return MaterialPageRoute(builder: (_) => const SellPage());
        return _notFound(settings.name);

      default:
        return _notFound(settings.name);
    }
  }

  static Route<dynamic> _notFound(String? name) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Not found')),
        body: Center(child: Text('No route for $name')),
      ),
    );
  }
}

// Helper args for make-offer
class MakeOfferArgs {
  final String title;
  final double price;
  final String? thumbUrl;
  const MakeOfferArgs({
    required this.title,
    required this.price,
    this.thumbUrl,
  });
}
