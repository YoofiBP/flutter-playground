import 'package:new_todo_list/models/todo.dart';
import 'package:test/test.dart';

void main() {
  group('Todo tests', () {
    test('Completed status should be changed', () {
      final todo = Todo(id: 1, title: 'title', completed: false);

      todo.toggleComplete();

      expect(todo.completed, true);
    });

    test('Title should be changed', () {
      final todo = Todo(id: 1, title: 'title', completed: false);

      var newTitle = 'new title';

      todo.todoTitle = newTitle;

      expect(todo.todoTitle, newTitle);
    });
  });
}
