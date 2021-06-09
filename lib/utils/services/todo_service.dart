import '../networking/http_client.dart';

abstract class AbstractTodoService {
  Future<List<dynamic>> getTodos();
  Future<dynamic> postTodo(String title, int userId);
  Future<bool> deleteTodo(int id);
  Future<dynamic> updateTodo(int id, Map<String, dynamic> update);
}

class HttpTodoService implements AbstractTodoService {
  final AbstractHttpClient client;

  HttpTodoService({required this.client});

  @override
  Future<List<dynamic>> getTodos() async {
    try {
      var todos = await client
          .get('https://jsonplaceholder.typicode.com/todos?userId=1');
      return todos;
    } on Exception catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<dynamic> updateTodo(int id, Map<String, dynamic> update) async {
    try {
      var updatedTodo = await client.update(
          'https://jsonplaceholder.typicode.com/todos/$id', update);
      return updatedTodo;
    } on Exception catch (_) {
      return false;
    }
  }

  @override
  Future<dynamic> postTodo(String title, int userId) async {
    try {
      var todo = await client.post('https://jsonplaceholder.typicode.com/todos',
          {'title': title, 'userId': userId});
      return todo;
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteTodo(int id) async {
    try {
      var deleted =
          await client.delete('https://jsonplaceholder.typicode.com/todos/$id');
      return deleted;
    } on Exception catch (_) {
      rethrow;
    }
  }
}

HttpTodoService httpTodoService = HttpTodoService(client: appClient);
