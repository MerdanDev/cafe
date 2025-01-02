class Product {
  final int id;
  final String name;
  final double price;
  final String image;
  final int categoryId;

//<editor-fold desc="Data Methods">
  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.categoryId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          price == other.price &&
          image == other.image &&
          categoryId == other.categoryId);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      price.hashCode ^
      image.hashCode ^
      categoryId.hashCode;

  @override
  String toString() {
    return 'Product{' +
        ' id: $id,' +
        ' name: $name,' +
        ' price: $price,' +
        ' image: $image,' +
        ' categoryId: $categoryId,' +
        '}';
  }

  Product copyWith({
    int? id,
    String? name,
    double? price,
    String? image,
    int? categoryId,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'price': this.price,
      'image': this.image,
      'categoryId': this.categoryId,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      name: map['name'] as String,
      price: map['price'] as double,
      image: map['image'] as String,
      categoryId: map['categoryId'] as int,
    );
  }

//</editor-fold>
}
