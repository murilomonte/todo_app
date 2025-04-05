
class UserModel {
  final int id;
  final String name;
  final String theme;
  final double score;
  UserModel({
    required this.id,
    required this.name,
    required this.theme,
    required this.score,
  });

  @override
  String toString() {
    return 'Id: $id, name: $name, theme: $theme, score: $score';
  }
}
