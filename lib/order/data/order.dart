import 'package:cafe/order/data/order_line.dart';

class Order {
  final int id;
  final DateTime dateTime;
  final List<OrderLine> lines;
  final int status;
  final int tableId;

//<editor-fold desc="Data Methods">
  const Order({
    required this.id,
    required this.dateTime,
    required this.lines,
    required this.status,
    required this.tableId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Order &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          dateTime == other.dateTime &&
          lines == other.lines &&
          status == other.status &&
          tableId == other.tableId);

  @override
  int get hashCode =>
      id.hashCode ^
      dateTime.hashCode ^
      lines.hashCode ^
      status.hashCode ^
      tableId.hashCode;

  @override
  String toString() {
    return 'Order{' +
        ' id: $id,' +
        ' dateTime: $dateTime,' +
        ' lines: $lines,' +
        ' status: $status,' +
        ' tableId: $tableId,' +
        '}';
  }

  Order copyWith({
    int? id,
    DateTime? dateTime,
    List<OrderLine>? lines,
    int? status,
    int? tableId,
  }) {
    return Order(
      id: id ?? this.id,
      dateTime: dateTime ?? this.dateTime,
      lines: lines ?? this.lines,
      status: status ?? this.status,
      tableId: tableId ?? this.tableId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'dateTime': this.dateTime.toString(),
      'lines': this.lines.map((e) => e.toMap()).toList(),
      'status': this.status,
      'tableId': this.tableId,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] as int,
      dateTime: DateTime.parse(map['dateTime'] as String),
      lines: (map['lines'] as List)
          .map((e) => OrderLine.fromMap(e as Map<String, dynamic>))
          .toList(),
      status: map['status'] as int,
      tableId: map['tableId'] as int,
    );
  }

//</editor-fold>
}
