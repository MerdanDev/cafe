import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cafe/core/shared_preference.dart';
import 'package:cafe/order/order.dart';

class OrderListCubit extends Cubit<List<Order>> {
  factory OrderListCubit() => instance;

  OrderListCubit._internal() : super([]);
  static OrderListCubit instance = OrderListCubit._internal();

  void loadData() {
    final rawData = SingletonSharedPreference.loadOrders();
    if (rawData == null || rawData.isEmpty) {
      return;
    }
    final decoded = jsonDecode(rawData);
    if (decoded is! List<dynamic>) {
      return;
    }
    final data = decoded.map(
      (e) {
        return Order.fromMap(e as Map<String, dynamic>);
      },
    ).toList();
    emit(data);
  }

  void completeOrder({required int id}) {
    final order = state.firstWhere((e) => e.id == id);
    state.removeWhere((e) => e.id == id);

    emit(
      [
        ...state,
        Order(
          id: order.id,
          dateTime: order.dateTime,
          lines: order.lines,
          status: 1,
          tableId: order.tableId,
        ),
      ],
    );

    final decoded =
        state.where((e) => e.status > 0).map((e) => e.toMap()).toList();
    SingletonSharedPreference.setOrders(
      jsonEncode(decoded),
    );
  }

  void createNewOrder({
    required int tableId,
    required int productId,
    required double price,
    required String name,
  }) {
    emit([
      ...state,
      Order(
        id: state.length + 1,
        dateTime: DateTime.now(),
        lines: [
          OrderLine(
            productId: productId,
            amount: 1,
            price: price,
            name: name,
          ),
        ],
        status: 0,
        tableId: tableId,
      ),
    ]);
  }

  void add({
    required int tableId,
    required int productId,
    required double price,
    required String name,
  }) {
    if (state.any(
      (order) => order.tableId == tableId && order.status == 0,
    )) {
      final order = state.firstWhere(
        (order) => order.tableId == tableId && order.status == 0,
      );
      if (order.lines.any(
        (line) => line.productId == productId,
      )) {
        final oldLine = order.lines.firstWhere(
          (line) => line.productId == productId,
        );
        order.lines.removeWhere(
          (line) => line.productId == productId,
        );
        order.lines.add(
          OrderLine(
            productId: productId,
            amount: oldLine.amount + 1,
            price: price,
            name: name,
          ),
        );
      } else {
        order.lines.add(
          OrderLine(
            productId: productId,
            amount: 1,
            price: price,
            name: name,
          ),
        );
      }
      state.removeWhere(
        (order) => order.tableId == tableId && order.status == 0,
      );

      emit([
        ...state,
        order,
      ]);
    } else {
      createNewOrder(
        tableId: tableId,
        productId: productId,
        price: price,
        name: name,
      );
    }
  }

  void remove({
    required int tableId,
    required int productId,
    required double price,
    required String name,
  }) {
    if (state.any(
      (order) => order.tableId == tableId && order.status == 0,
    )) {
      final order = state.firstWhere(
        (order) => order.tableId == tableId && order.status == 0,
      );
      if (order.lines.any(
        (line) => line.productId == productId,
      )) {
        final oldLine = order.lines.firstWhere(
          (line) => line.productId == productId,
        );
        order.lines.removeWhere(
          (line) => line.productId == productId,
        );
        if (oldLine.amount > 1) {
          order.lines.add(
            OrderLine(
              productId: productId,
              amount: oldLine.amount - 1,
              price: price,
              name: name,
            ),
          );
        }
      } else {
        return;
      }
      state.removeWhere(
        (order) => order.tableId == tableId && order.status == 0,
      );

      emit([
        ...state,
        order,
      ]);
    } else {
      return;
    }
  }
}
