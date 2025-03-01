class TaskModel {
  int id;
  int userId;
  String title;
  String description;
  double points;
  int status;
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
}
