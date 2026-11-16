import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/app_style.dart';
import '../widgets/cart_button.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product, required this.cart, required this.onAdd});
  final Product product;
  final ValueNotifier<Map<int, int>> cart;
  final void Function(int id) onAdd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ürün detayı', style: TextStyle(fontWeight: FontWeight.w800)),
        actions: [CartButton(cart: cart), const SizedBox(width: 12)],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 9, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: AspectRatio(aspectRatio: 1.18, child: Image.asset(product.image, fit: BoxFit.cover, width: double.infinity)),
                  ),
                  const SizedBox(height: 25),
                  Text(product.category.toUpperCase(), style: const TextStyle(color: AppStyle.green, fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1.2)),
                  const SizedBox(height: 8),
                  Text(product.name, style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 10),
                  Text(formatPrice(product.price), style: const TextStyle(fontSize: 23, color: AppStyle.green, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 23),
                  const Text('Ürün hakkında', style: TextStyle(fontSize: 18, color: AppStyle.navy, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  Text(product.description, style: const TextStyle(fontSize: 14, color: AppStyle.muted, height: 1.65)),
                  const SizedBox(height: 23),
                  const Text('Özellikler', style: TextStyle(fontSize: 18, color: AppStyle.navy, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 10),
                  ...product.features.map((feature) => Padding(
                        padding: const EdgeInsets.only(bottom: 9),
                        child: Row(children: [
                          const Icon(Icons.check_circle_outline, color: AppStyle.green, size: 18),
                          const SizedBox(width: 9),
                          Expanded(child: Text(feature, style: const TextStyle(color: AppStyle.navy))),
                        ]),
                      )),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 18),
            color: Colors.white,
            width: double.infinity,
            child: SafeArea(
              top: false,
              child: FilledButton.icon(
                onPressed: () {
                  onAdd(product.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${product.name} sepete eklendi.'), duration: const Duration(seconds: 2)),
                  );
                },
                icon: const Icon(Icons.add_shopping_cart_outlined),
                label: const Text('Sepete ekle', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
