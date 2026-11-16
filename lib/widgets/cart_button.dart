import 'package:flutter/material.dart';
import 'app_style.dart';

class CartButton extends StatelessWidget {
  const CartButton({super.key, required this.cart});

  final ValueNotifier<Map<int, int>> cart;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Map<int, int>>(
      valueListenable: cart,
      builder: (context, values, _) {
        final count = values.values.fold<int>(0, (sum, n) => sum + n);
        return IconButton(
          tooltip: 'Sepet',
          onPressed: () => Navigator.pushNamed(context, '/cart'),
          icon: Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(Icons.shopping_bag_outlined, size: 27, color: AppStyle.navy),
              if (count > 0)
                Positioned(
                  right: -8,
                  top: -7,
                  child: Container(
                    constraints: const BoxConstraints(minWidth: 17, minHeight: 17),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: const BoxDecoration(color: AppStyle.green, shape: BoxShape.circle),
                    child: Text('$count', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
