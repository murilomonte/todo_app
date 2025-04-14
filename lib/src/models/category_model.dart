class CategoryModel {
  final int id;
  final String name;
  final double totalPoints;
  CategoryModel({
    required this.id,
    required this.name,
    required this.totalPoints,
  });

  @override
  String toString() {
    return 'Id: $id, Name: $name, TotalPoints: $totalPoints';
  }

  // Retorna uma cópia desse objeto
  CategoryModel copyWith({int? id, String? name, double? totalPoints}) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      totalPoints: totalPoints ?? this.totalPoints,
    );
  }
}
