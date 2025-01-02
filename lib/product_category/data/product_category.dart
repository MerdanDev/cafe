class ProductCategory {
  final int id;
  final String name;
  final String imagePath;

//<editor-fold desc="Data Methods">
  const ProductCategory({
    required this.id,
    required this.name,
    required this.imagePath,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductCategory &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          imagePath == other.imagePath);

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ imagePath.hashCode;

  @override
  String toString() {
    return 'ProductCategory{' +
        ' id: $id,' +
        ' name: $name,' +
        ' imagePath: $imagePath,' +
        '}';
  }

  ProductCategory copyWith({
    int? id,
    String? name,
    String? imagePath,
  }) {
    return ProductCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'imagePath': this.imagePath,
    };
  }

  factory ProductCategory.fromMap(Map<String, dynamic> map) {
    return ProductCategory(
      id: map['id'] as int,
      name: map['name'] as String,
      imagePath: map['imagePath'] as String,
    );
  }

//</editor-fold>
}
