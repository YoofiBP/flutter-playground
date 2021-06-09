import '../../../../models/todo.dart';
import '../models/app_state.dart';
import '../models/user_info.dart';

bool isBusySelector(AppState state) => state.authState.isBusy;

bool isLoggedInSelector(AppState state) => state.authState.isLoggedIn;

UserInfo userInfoSelector(AppState state) => state.authState.userInfo;

List<Todo> todosSelector(AppState state) => state.todos.todos;
