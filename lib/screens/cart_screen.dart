import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/app_style.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key, required this.products, required this.cart, required this.onRemove});
  final List<Product> products;
  final ValueNotifier<Map<int, int>> cart;
  final void Function(int id) onRemove;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sepetim', style: TextStyle(fontWeight: FontWeight.w800))),
      body: ValueListenableBuilder<Map<int, int>>(
        valueListenable: cart,
        builder: (context, items, _) {
          if (items.isEmpty) {
            return const Center(child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.shopping_bag_outlined, color: AppStyle.muted, size: 62),
                SizedBox(height: 16),
                Text('Sepetin henüz boş.', style: TextStyle(color: AppStyle.navy, fontSize: 20, fontWeight: FontWeight.w700)),
                SizedBox(height: 8),
                Text('Ürün detayından sepetine ürün ekleyebilirsin.', style: TextStyle(color: AppStyle.muted)),
              ],
            ));
          }
          final selected = products.where((product) => items.containsKey(product.id)).toList();
          final total = selected.fold<double>(0, (sum, product) => sum + product.price * (items[product.id] ?? 0));
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: selected.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final product = selected[index];
                    return Card(
                      elevation: 0,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(children: [
                          ClipRRect(borderRadius: BorderRadius.circular(11),
                            child: Image.asset(product.image, width: 76, height: 76, fit: BoxFit.cover)),
                          const SizedBox(width: 12),
                          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(product.name, style: const TextStyle(fontWeight: FontWeight.w700, color: AppStyle.navy)),
                            const SizedBox(height: 5),
                            Text('Adet: ${items[product.id]}', style: const TextStyle(color: AppStyle.muted, fontSize: 12)),
                            const SizedBox(height: 5),
                            Text(formatPrice(product.price * items[product.id]!), style: const TextStyle(color: AppStyle.green, fontWeight: FontWeight.w800)),
                          ])),
                          IconButton(tooltip: 'Bir adet çıkar', onPressed: () => onRemove(product.id), icon: const Icon(Icons.remove_circle_outline, color: AppStyle.muted)),
                        ]),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                color: Colors.white,
                child: SafeArea(top: false, child: Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    const Text('Toplam', style: TextStyle(fontSize: 16, color: AppStyle.navy)),
                    Text(formatPrice(total), style: const TextStyle(fontSize: 21, color: AppStyle.green, fontWeight: FontWeight.w800)),
                  ]),
                  const SizedBox(height: 14),
                  const Text('Bu sepet eğitim amaçlıdır; gerçek ödeme yapılmaz.', style: TextStyle(color: AppStyle.muted, fontSize: 12)),
                ])),
              ),
            ],
          );
        },
      ),
    );
  }
}
