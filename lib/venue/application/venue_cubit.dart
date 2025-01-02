import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cafe/core/shared_preference.dart';
import 'package:cafe/venue/venue.dart';

class VenueCubit extends Cubit<List<Venue>> {
  factory VenueCubit() => instance;
  VenueCubit._internal() : super(<Venue>[]);

  static VenueCubit instance = VenueCubit._internal();

  void loadData() {
    final rawData = SingletonSharedPreference.loadVenue();
    if (rawData == null || rawData.isEmpty) {
      return;
    }
    final decoded = jsonDecode(rawData);
    if (decoded is! List<dynamic>) {
      return;
    }
    final data = decoded.map(
      (e) {
        return Venue.fromMap(e as Map<String, dynamic>);
      },
    ).toList();
    emit(data);
  }

  void getFromFile(List<dynamic> decoded) {
    final data = decoded.map(
      (e) {
        return Venue.fromMap(e as Map<String, dynamic>);
      },
    ).toList();
    emit(data);
    SingletonSharedPreference.setVenues(jsonEncode(decoded));
  }
}
