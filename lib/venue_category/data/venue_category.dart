class VenueCategory {
  final int id;
  final String name;

//<editor-fold desc="Data Methods">
  const VenueCategory({
    required this.id,
    required this.name,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VenueCategory &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name);

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  @override
  String toString() {
    return 'CustomCategoryEntity{' + ' id: $id,' + ' name: $name,' + '}';
  }

  VenueCategory copyWith({
    int? id,
    String? name,
  }) {
    return VenueCategory(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
    };
  }

  factory VenueCategory.fromMap(Map<String, dynamic> map) {
    return VenueCategory(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

//</editor-fold>
}
