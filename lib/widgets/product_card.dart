import 'package:flutter/material.dart';
import '../models/product.dart';
import 'app_style.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.white,
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, '/detail', arguments: product),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Image.asset(product.image, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 11, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.category, maxLines: 1, overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: AppStyle.muted, fontSize: 11)),
                  const SizedBox(height: 3),
                  Text(product.name, maxLines: 1, overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: AppStyle.navy, fontSize: 14, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 7),
                  Text(formatPrice(product.price),
                      style: const TextStyle(color: AppStyle.green, fontSize: 15, fontWeight: FontWeight.w800)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
