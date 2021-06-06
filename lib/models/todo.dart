import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart';

@JsonSerializable()
class Todo {
  Todo({
    required this.id,
    required this.title,
    required this.completed,
  });

  @JsonKey(required: true)
  int id;

  @JsonKey(required: true)
  String title;

  @JsonKey(defaultValue: false)
  bool completed;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  Map<String, dynamic> toJson() => _$TodoToJson(this);

  void toggleComplete() {
    completed = !completed;
  }

  set setTitle(String title) {
    this.title = title;
  }
}
