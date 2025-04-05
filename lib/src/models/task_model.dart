class TaskModel {
  final int id;
  final int userId;
  final String title;
  final String description;
  final double points;
  final int status;
  TaskModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.points,
    required this.status,
  });

  @override
  String toString() {
    return 'Id: $id, userId: $userId, title: $title, description: $description, score: $points, status: $status';
  }

  // Adicione este método
  // Retorna uma cópia desse objeto
  TaskModel copyWith({
    int? id,
    int? userId,
    String? title,
    String? description,
    double? points,
    int? status,
  }) {
    return TaskModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      points: points ?? this.points,
      status: status ?? this.status,
    );
  }
}
