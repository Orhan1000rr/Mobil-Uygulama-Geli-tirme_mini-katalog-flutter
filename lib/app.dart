import 'package:flutter/material.dart';
import 'data/product_repository.dart';
import 'models/product.dart';
import 'screens/cart_screen.dart';
import 'screens/home_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/products_screen.dart';
import 'widgets/app_style.dart';

class MiniKatalogApp extends StatefulWidget {
  const MiniKatalogApp({super.key});

  @override
  State<MiniKatalogApp> createState() => _MiniKatalogAppState();
}

class _MiniKatalogAppState extends State<MiniKatalogApp> {
  late final Future<List<Product>> _productsFuture;
  final ValueNotifier<Map<int, int>> _cart = ValueNotifier({});

  @override
  void initState() {
    super.initState();
    _productsFuture = const ProductRepository().loadProducts();
  }

  void _addToCart(int id) {
    final newCart = Map<int, int>.of(_cart.value);
    newCart[id] = (newCart[id] ?? 0) + 1;
    _cart.value = newCart;
  }

  void _removeFromCart(int id) {
    final newCart = Map<int, int>.of(_cart.value);
    final quantity = newCart[id] ?? 0;
    if (quantity <= 1) {
      newCart.remove(id);
    } else {
      newCart[id] = quantity - 1;
    }
    _cart.value = newCart;
  }

  @override
  void dispose() {
    _cart.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: _productsFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppStyle.theme(),
            home: Scaffold(body: Center(child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text('Ürünler yüklenemedi: ${snapshot.error}', textAlign: TextAlign.center),
            ))),
          );
        }
        if (!snapshot.hasData) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppStyle.theme(),
            home: const Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        }
        final products = snapshot.data!;
        return MaterialApp(
          title: 'Mini Katalog',
          debugShowCheckedModeBanner: false,
          theme: AppStyle.theme(),
          initialRoute: '/',
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/':
                return MaterialPageRoute<void>(
                  settings: settings,
                  builder: (_) => HomeScreen(products: products, cart: _cart),
                );
              case '/products':
                return MaterialPageRoute<void>(
                  settings: settings,
                  builder: (_) => ProductsScreen(
                    products: products,
                    cart: _cart,
                    initialCategory: settings.arguments as String?,
                  ),
                );
              case '/detail':
                final product = settings.arguments as Product;
                return MaterialPageRoute<void>(
                  settings: settings,
                  builder: (_) => ProductDetailScreen(product: product, cart: _cart, onAdd: _addToCart),
                );
              case '/cart':
                return MaterialPageRoute<void>(
                  settings: settings,
                  builder: (_) => CartScreen(products: products, cart: _cart, onRemove: _removeFromCart),
                );
              default:
                return MaterialPageRoute<void>(
                  builder: (_) => HomeScreen(products: products, cart: _cart),
                );
            }
          },
        );
      },
    );
  }
}
