class Todo {
  const Todo({
    required this.id,
    required this.title,
    required this.completed,
  });

  final int id;
  final String title;
  final bool completed;

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
        id: json['id'] as int,
        title: json['title'] as String,
        completed: json['completed'] as bool);
  }
}
