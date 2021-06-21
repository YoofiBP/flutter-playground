import 'package:redux/redux.dart';

import '../models/todo.dart';
import '../utils/state_management/redux/actions/actions.dart';
import '../utils/state_management/redux/models/app_state.dart';
import '../utils/state_management/redux/selectors/selectors.dart';

/* class TodoListContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TodoListModel>(
        builder: (context, todoList, child) => TodoListScreen(
            todos: todoList.todos,
            onSettingsPress: () {
              Navigator.pushNamed(context, Routes.settings);
            },
            deleteTodo: todoList.delete,
            updateTodo: todoList.update));
  }
} */

class ViewModel {
  final void Function() onSettingsPress;
  final void Function() onInit;
  final void Function(int id) deleteTodo;
  final void Function(Todo todo) updateTodo;
  final List<Todo> todos;

  ViewModel(
      {required this.onSettingsPress,
      required this.onInit,
      required this.todos,
      required this.deleteTodo,
      required this.updateTodo});

  factory ViewModel.create(Store<AppState> store) {
    return ViewModel(
        onSettingsPress: () {
          store.dispatch(NavigationAction(route: '/settings'));
        },
        onInit: () {
          store.dispatch(FetchTodos());
        },
        todos: todosSelector(store.state),
        updateTodo: (todo) {
          store.dispatch(
              RequestUpdateTodo(id: todo.id, updateBody: todo.toJson()));
        },
        deleteTodo: (id) {
          store.dispatch(RequestDeleteTodo(id: id));
        });
  }
}
