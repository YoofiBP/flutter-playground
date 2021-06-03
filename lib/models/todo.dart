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

  @JsonKey(required: true, defaultValue: false)
  bool completed;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  Map<String, dynamic> toJson() => _$TodoToJson(this);

  /* factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
        id: json['id'] as int,
        title: json['title'] as String,
        completed: json['completed'] as bool);
  } */
}
