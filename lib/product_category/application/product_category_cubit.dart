import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cafe/core/shared_preference.dart';
import 'package:cafe/core/utils.dart';
import 'package:cafe/product_category/product_category.dart';

class ProductCategoryCubit extends Cubit<List<ProductCategory>> {
  factory ProductCategoryCubit() => instance;
  ProductCategoryCubit._internal() : super(<ProductCategory>[]);

  static ProductCategoryCubit instance = ProductCategoryCubit._internal();

  void loadData() {
    final rawData = SingletonSharedPreference.loadProductCategories();
    if (rawData == null || rawData.isEmpty) {
      return;
    }
    final decoded = jsonDecode(rawData);
    if (decoded is! List<dynamic>) {
      return;
    }
    final data = decoded.map(
      (e) {
        return ProductCategory.fromMap(e as Map<String, dynamic>);
      },
    ).toList();
    emit(data);
  }

  Future<void> getFromFile(List<dynamic> decoded) async {
    for (final category in decoded) {
      if (category is Map<String, dynamic>) {
        final base64Image = category['image'] as String;
        final imageData = decodeBase64Image(base64Image);
        final imagePath = await saveImageToStorage(
          imageData,
          name: 'category-image-${category['id']}',
        );
        category.remove('image');
        category['imagePath'] = imagePath;
      }
    }

    final data = decoded.map((e) {
      return ProductCategory.fromMap(e as Map<String, dynamic>);
    }).toList();
    emit(data);
    await SingletonSharedPreference.setProductCategories(jsonEncode(decoded));
  }
}
