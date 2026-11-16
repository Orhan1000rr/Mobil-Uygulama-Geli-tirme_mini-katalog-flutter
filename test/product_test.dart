import 'package:flutter_test/flutter_test.dart';
import 'package:mini_katalog/models/product.dart';

void main() {
  test('Ürün JSON verisi modele çevrilebilir', () {
    final product = Product.fromJson({
      'id': 1,
      'name': 'Kablosuz Kulaklık',
      'category': 'Teknoloji',
      'price': 1299,
      'image': 'assets/images/kulaklik.png',
      'description': 'Örnek ürün',
      'features': ['Bluetooth bağlantı'],
    });

    expect(product.name, 'Kablosuz Kulaklık');
    expect(product.price, 1299.0);
    expect(product.toJson()['features'], ['Bluetooth bağlantı']);
  });
}
