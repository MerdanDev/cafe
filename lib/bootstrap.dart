import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cafe/core/shared_preference.dart';
import 'package:cafe/order/order.dart';
import 'package:cafe/product/product.dart';
import 'package:cafe/product_category/product_category.dart';
import 'package:cafe/venue/venue.dart';
import 'package:cafe/venue_category/venue_category.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  // Add cross-flavor configuration here

  final pref = await SharedPreferences.getInstance();
  SingletonSharedPreference.init(pref);

  VenueCategoryCubit.instance.loadData();
  VenueCubit.instance.loadData();
  ProductCategoryCubit.instance.loadData();
  ProductCubit.instance.loadData();
  OrderListCubit.instance.loadData();

  runApp(await builder());
}
