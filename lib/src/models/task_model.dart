class TaskModel {
  final int id;
  final int userId;
  final int categoryId;
  final String title;
  final String description;
  final double points;
  final int status;
  TaskModel({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.title,
    required this.description,
    required this.points,
    required this.status,
  });

  @override
  String toString() {
    return 'Id: $id, userId: $userId, categoryId: $categoryId, title: $title, description: $description, score: $points, status: $status';
  }
  
  // Retorna uma cópia desse objeto
  TaskModel copyWith({
    int? id,
    int? userId,
    int? categoryId,
    String? title,
    String? description,
    double? points,
    int? status,
  }) {
    return TaskModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      categoryId: categoryId ?? this.categoryId,
      title: title ?? this.title,
      description: description ?? this.description,
      points: points ?? this.points,
      status: status ?? this.status,
    );
  }
}
