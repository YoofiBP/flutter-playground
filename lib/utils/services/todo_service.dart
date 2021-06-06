import '../networking/http_client.dart';

abstract class AbstractTodoService {
  Future<List<dynamic>> getTodos() async => [];
  Future<dynamic> postTodo(String title, int userId) async {}
  Future<bool> deleteTodo(int id) async => false;
  Future<dynamic> updateTodo(int id, Map<String, dynamic> update) async =>
      false;
}

class HttpTodoService implements AbstractTodoService {
  @override
  Future<List<dynamic>> getTodos() async {
    try {
      var todos = await appClient
          .get('https://jsonplaceholder.typicode.com/todos?userId=1');
      return todos;
    } on Exception catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<dynamic> updateTodo(int id, Map<String, dynamic> update) async {
    try {
      var updatedTodo = await appClient.update(
          'https://jsonplaceholder.typicode.com/todos/$id', update);
      return updatedTodo;
    } on Exception catch (_) {
      return false;
    }
  }

  @override
  Future<dynamic> postTodo(String title, int userId) async {
    try {
      var todo = await appClient.post(
          'https://jsonplaceholder.typicode.com/todos',
          {'title': title, 'userId': userId});
      return todo;
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteTodo(int id) async {
    try {
      var deleted = await appClient
          .delete('https://jsonplaceholder.typicode.com/todos/$id');
      return deleted;
    } on Exception catch (_) {
      rethrow;
    }
  }
}

HttpTodoService httpTodoService = HttpTodoService();
