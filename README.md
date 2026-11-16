# Mini Katalog – Flutter Mobil Uygulama

Temel Flutter eğitimi için hazırlanan küçük bir ürün katalog uygulaması. Ana sayfada öne çıkan ürünler ve kategoriler, ürünler sayfasında arama/filtreleme, detay sayfasında ürün bilgileri ve basit sepet simülasyonu bulunur.

## Teknik bilgiler

- **Teknoloji:** Flutter / Dart, Material Design 3
- **Hedeflenen sürüm:** Flutter 3.35.x / Dart 3.x (bu ortamda Flutter SDK çalıştırılarak doğrulanmadı; kullandığınız kesin sürümü `flutter --version` ile güncelleyin)
- **Paketler:** Flutter SDK dışında çalışma zamanı paketi kullanılmaz.
- **Veri kaynağı:** `assets/data/products.json` (yerel JSON simülasyonu; internet gerekmez)
- **Görseller:** `assets/images/` altında projeye ait örnek ürün çizimleri

## Özellikler

- Ana sayfa, ürün listesi, ürün detayı ve sepet
- `Navigator.pushNamed` ve route arguments ile sayfa geçişi
- `GridView.builder` ile ürün kartları
- JSON -> `Product.fromJson` ve `toJson` modeli
- Ürün arama ve kategori filtresi
- `ValueNotifier` ile sepete ekleme / çıkarma işlemi
- `Image.asset` ile görsel kullanımı

## Windows 11'de çalıştırma

**Ön gereksinimler:** Flutter SDK, Dart SDK (Flutter ile birlikte gelir), Visual Studio Code, Android Studio ve çalışan bir Android Emulator (veya USB ile bağlı Android telefon).

1. Bu repoyu bilgisayarınıza indirin / klonlayın ve VS Code'da klasörü açın.
2. VS Code > Terminal > New Terminal menüsünü açın.
3. Proje kökünde aşağıdaki komutları sırasıyla çalıştırın:

   ```powershell
   flutter doctor
   flutter create --platforms=android,ios .
   flutter pub get
   flutter devices
   flutter run
   ```

   **Neden `flutter create`?** Bu kaynak proje, Android ve iOS platform şablonlarını içermez. Bu komut eksik platform dosyalarını kendi kurulu Flutter sürümünüzle üretir. `lib`, `assets` ve README dosyalarını değiştirmeden çalıştırılmalıdır. Android emülatör veya fiziksel Android cihaz açılmadan `flutter run` çalışmaz.

4. Uygulama açıldığında ana sayfada **Ürünleri incele** butonuna basın. Ürün kartlarından birine dokunarak detay ekranına gidin. **Sepete ekle** butonuna basıp sağ üstteki sepetten güncellemeyi kontrol edin.

**iOS notu:** Kaynak kod çoklu platforma uygundur; iOS derlemesi için macOS ve Xcode gerekir. Windows 11'de Android sürümü test edilebilir.

## Test

```powershell
flutter test
flutter analyze
```

`test/product_test.dart` dosyası JSON-model dönüşümünün örnek birim testini içerir. Yukarıdaki komutlar bu hazırlama ortamında yürütülememiştir; çalıştırma ve cihaz testi kullanıcı bilgisayarında yapılmalıdır.

## Klasör yapısı

```text
lib/
  main.dart
  app.dart
  data/product_repository.dart
  models/product.dart
  screens/home_screen.dart
  screens/products_screen.dart
  screens/product_detail_screen.dart
  screens/cart_screen.dart
  widgets/app_style.dart
  widgets/cart_button.dart
  widgets/product_card.dart
assets/
  data/products.json
  images/
test/product_test.dart
docs/onizleme/
```

## Proje teslimi / ekran görüntüleri

`docs/onizleme/` içindeki üç PNG **tasarım önizlemesidir**; çalıştırılmış Flutter emülatöründen çekilmiş gerçek ekran görüntüleri değildir. Projeyi Android emülatörde açtıktan sonra ana sayfa, ürün listesi ve ürün detayını cihaz ekran görüntüsüyle kaydedip gerçek teslim ekran görüntüleriyle değiştirin.

Eğitim yönergesindeki alternatif demo uç noktaları (`wantapi.com`, Fake Store API, DummyJSON) bu sürümde çağrılmıyor. Proje, paket gerektirmeyen yerel JSON simülasyonu kullanıyor.

*Ürün adları, fiyatları ve açıklamaları eğitim amaçlı örnek verilerdir. Sepet gerçek sipariş veya ödeme oluşturmaz.*
