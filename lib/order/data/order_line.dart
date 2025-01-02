class OrderLine {
  final int productId;
  final int amount;
  final String name;
  final double price;

//<editor-fold desc="Data Methods">
  const OrderLine({
    required this.productId,
    required this.amount,
    required this.name,
    required this.price,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderLine &&
          runtimeType == other.runtimeType &&
          productId == other.productId &&
          amount == other.amount &&
          name == other.name &&
          price == other.price);

  @override
  int get hashCode =>
      productId.hashCode ^ amount.hashCode ^ name.hashCode ^ price.hashCode;

  @override
  String toString() {
    return 'OrderLine{' +
        ' productId: $productId,' +
        ' amount: $amount,' +
        ' name: $name,' +
        ' price: $price,' +
        '}';
  }

  OrderLine copyWith({
    int? productId,
    int? amount,
    String? name,
    double? price,
  }) {
    return OrderLine(
      productId: productId ?? this.productId,
      amount: amount ?? this.amount,
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': this.productId,
      'amount': this.amount,
      'name': this.name,
      'price': this.price,
    };
  }

  factory OrderLine.fromMap(Map<String, dynamic> map) {
    return OrderLine(
      productId: map['productId'] as int,
      amount: map['amount'] as int,
      name: map['name'] as String,
      price: map['price'] as double,
    );
  }

//</editor-fold>
}
