import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cafe/core/shared_preference.dart';
import 'package:cafe/venue_category/venue_category.dart';

class VenueCategoryCubit extends Cubit<List<VenueCategory>> {
  factory VenueCategoryCubit() => instance;
  VenueCategoryCubit._internal() : super(<VenueCategory>[]);

  static VenueCategoryCubit instance = VenueCategoryCubit._internal();

  void loadData() {
    final rawData = SingletonSharedPreference.loadVenueCategories();
    if (rawData == null || rawData.isEmpty) {
      return;
    }
    final decoded = jsonDecode(rawData);
    if (decoded is! List<dynamic>) {
      return;
    }
    final data = decoded.map(
      (e) {
        return VenueCategory.fromMap(e as Map<String, dynamic>);
      },
    ).toList();
    emit(data);
  }

  void getFromFile(List<dynamic> decoded) {
    final data = decoded.map(
      (e) {
        return VenueCategory.fromMap(e as Map<String, dynamic>);
      },
    ).toList();
    emit(data);
    SingletonSharedPreference.setVenueCategories(jsonEncode(decoded));
  }
}
