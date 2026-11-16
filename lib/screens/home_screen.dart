import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/app_style.dart';
import '../widgets/cart_button.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.products, required this.cart});
  final List<Product> products;
  final ValueNotifier<Map<int, int>> cart;

  @override
  Widget build(BuildContext context) {
    final featured = products.take(4).toList();
    const categories = ['Teknoloji', 'Ev & Yaşam', 'Aksesuar', 'Kırtasiye'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('mini katalog', style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: -0.6)),
        actions: [CartButton(cart: cart), const SizedBox(width: 12)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 11),
            const Text('Merhaba, hoş geldin 👋', style: TextStyle(fontSize: 13, color: AppStyle.muted)),
            const SizedBox(height: 7),
            const Text('Yeni şeyler keşfet.', style: TextStyle(fontSize: 28, color: AppStyle.navy, fontWeight: FontWeight.w800)),
            const SizedBox(height: 19),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppStyle.navy,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('HAFTANIN SEÇKİSİ', style: TextStyle(color: Color(0xFF96E4D3), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.2)),
                          const SizedBox(height: 11),
                          const Text('Günlük hayatına\nküçük dokunuşlar', style: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.w800, height: 1.2)),
                          const SizedBox(height: 16),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              side: const BorderSide(color: Color(0xFF6A938F)),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
                            ),
                            onPressed: () => Navigator.pushNamed(context, '/products'),
                            child: const Text('Ürünleri incele'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.local_mall_outlined, color: Color(0xFF8CD7C8), size: 85),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 26),
            const Text('Kategoriler', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 19, color: AppStyle.navy)),
            const SizedBox(height: 12),
            SizedBox(
              height: 42,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) => ActionChip(
                  label: Text(categories[index]),
                  backgroundColor: Colors.white,
                  side: BorderSide.none,
                  labelStyle: const TextStyle(color: AppStyle.navy, fontWeight: FontWeight.w600),
                  onPressed: () => Navigator.pushNamed(context, '/products', arguments: categories[index]),
                ),
              ),
            ),
            const SizedBox(height: 27),
            Row(
              children: [
                const Expanded(child: Text('Öne çıkan ürünler', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 19, color: AppStyle.navy))),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/products'),
                  child: const Text('Tümünü gör', style: TextStyle(color: AppStyle.green, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: featured.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12,
                childAspectRatio: 0.73,
              ),
              itemBuilder: (context, index) => ProductCard(product: featured[index]),
            ),
          ],
        ),
      ),
    );
  }
}
