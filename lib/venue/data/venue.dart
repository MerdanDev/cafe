class Venue {
  final int id;
  final String name;
  final int categoryId;

//<editor-fold desc="Data Methods">
  const Venue({
    required this.id,
    required this.name,
    required this.categoryId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Venue &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          categoryId == other.categoryId);

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ categoryId.hashCode;

  @override
  String toString() {
    return 'Custom{' +
        ' id: $id,' +
        ' name: $name,' +
        ' categoryId: $categoryId,' +
        '}';
  }

  Venue copyWith({
    int? id,
    String? name,
    int? categoryId,
  }) {
    return Venue(
      id: id ?? this.id,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'categoryId': categoryId,
    };
  }

  factory Venue.fromMap(Map<String, dynamic> map) {
    return Venue(
      id: map['id'] as int,
      name: map['name'] as String,
      categoryId: map['categoryId'] as int,
    );
  }

//</editor-fold>
}
