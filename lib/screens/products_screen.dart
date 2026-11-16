import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/app_style.dart';
import '../widgets/cart_button.dart';
import '../widgets/product_card.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key, required this.products, required this.cart, this.initialCategory});
  final List<Product> products;
  final ValueNotifier<Map<int, int>> cart;
  final String? initialCategory;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final TextEditingController _searchController = TextEditingController();
  late String _category;

  @override
  void initState() {
    super.initState();
    _category = widget.initialCategory ?? 'Tümü';
    _searchController.addListener(_refresh);
  }

  void _refresh() => setState(() {});

  @override
  void dispose() {
    _searchController.removeListener(_refresh);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ['Tümü', ...widget.products.map((product) => product.category).toSet()];
    final query = _searchController.text.trim().toLowerCase();
    final filtered = widget.products.where((product) {
      final categoryMatches = _category == 'Tümü' || product.category == _category;
      final queryMatches = product.name.toLowerCase().contains(query) || product.category.toLowerCase().contains(query);
      return categoryMatches && queryMatches;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Ürünler', style: TextStyle(fontWeight: FontWeight.w800)),
        actions: [CartButton(cart: widget.cart), const SizedBox(width: 12)]),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 13),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: AppStyle.muted),
                hintText: 'Ürün veya kategori ara',
                hintStyle: const TextStyle(color: AppStyle.muted, fontSize: 14),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ),
          SizedBox(
            height: 48,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final selected = _category == category;
                return ChoiceChip(
                  label: Text(category),
                  selected: selected,
                  showCheckmark: false,
                  onSelected: (_) => setState(() => _category = category),
                  selectedColor: AppStyle.green,
                  backgroundColor: Colors.white,
                  side: BorderSide.none,
                  labelStyle: TextStyle(color: selected ? Colors.white : AppStyle.navy, fontWeight: FontWeight.w600),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 17, 20, 12),
            child: Text('${filtered.length} ürün bulundu', style: const TextStyle(color: AppStyle.muted, fontSize: 13)),
          ),
          Expanded(
            child: filtered.isEmpty
                ? const Center(child: Text('Aramana uygun ürün bulunamadı.'))
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                    itemCount: filtered.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.73,
                    ),
                    itemBuilder: (context, index) => ProductCard(product: filtered[index]),
                  ),
          ),
        ],
      ),
    );
  }
}
