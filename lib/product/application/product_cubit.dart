import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cafe/core/shared_preference.dart';
import 'package:cafe/core/utils.dart';
import 'package:cafe/product/product.dart';

class ProductCubit extends Cubit<List<Product>> {
  factory ProductCubit() => instance;
  ProductCubit._internal() : super(<Product>[]);

  static ProductCubit instance = ProductCubit._internal();

  void loadData() {
    final rawData = SingletonSharedPreference.loadProducts();
    if (rawData == null || rawData.isEmpty) {
      return;
    }
    final decoded = jsonDecode(rawData);
    if (decoded is! List<dynamic>) {
      return;
    }
    final data = decoded.map(
      (e) {
        return Product.fromMap(e as Map<String, dynamic>);
      },
    ).toList();
    emit(data);
  }

  Future<void> getFromFile(List<dynamic> decoded) async {
    for (final product in decoded) {
      if (product is Map<String, dynamic>) {
        final base64Image = product['image'] as String;
        final imageData = decodeBase64Image(base64Image);
        final imagePath = await saveImageToStorage(
          imageData,
          name: 'product-image-${product['id']}',
        );
        product['image'] = imagePath;
      }
    }

    final data = decoded.map((e) {
      return Product.fromMap(e as Map<String, dynamic>);
    }).toList();
    emit(data);
    await SingletonSharedPreference.setProducts(jsonEncode(decoded));
  }
}
