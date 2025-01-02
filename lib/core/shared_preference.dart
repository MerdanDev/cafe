import 'package:cafe/core/preference_key_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SingletonSharedPreference {
  factory SingletonSharedPreference() {
    return instance;
  }

  SingletonSharedPreference._internal(this._pref);

  static void init(SharedPreferences pref) {
    instance = SingletonSharedPreference._internal(pref);
  }

  static late SingletonSharedPreference instance;

  final SharedPreferences _pref;

  // static bool checkTokenTime() {
  //   final data = instance._pref.getString(PreferenceKeyData.tokenTime);
  //   if (data != null) {
  //     final date = DateTime.parse(data);
  //     return date.add(const Duration(days: 30)).compareTo(DateTime.now()) < 1;
  //   } else {
  //     return true;
  //   }
  // }

  static String? loadVenueCategories() {
    return instance._pref.getString(PreferenceKeyData.venueCategories);
  }

  static Future<bool> setVenueCategories(String data) {
    return instance._pref.setString(PreferenceKeyData.venueCategories, data);
  }

  static String? loadVenue() {
    return instance._pref.getString(PreferenceKeyData.venues);
  }

  static Future<bool> setVenues(String data) {
    return instance._pref.setString(PreferenceKeyData.venues, data);
  }

  static String? loadProductCategories() {
    return instance._pref.getString(PreferenceKeyData.productCategories);
  }

  static Future<bool> setProductCategories(String data) {
    return instance._pref.setString(PreferenceKeyData.productCategories, data);
  }

  static String? loadProducts() {
    return instance._pref.getString(PreferenceKeyData.products);
  }

  static Future<bool> setProducts(String data) {
    return instance._pref.setString(PreferenceKeyData.products, data);
  }

  static String? loadOrders() {
    return instance._pref.getString(PreferenceKeyData.orders);
  }

  static Future<bool> setOrders(String data) {
    return instance._pref.setString(PreferenceKeyData.orders, data);
  }
}
