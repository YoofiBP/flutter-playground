import '../networking/http_client.dart';

abstract class AbstractTodoService {
  Future<List<dynamic>> getTodos() async => [];
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
}

HttpTodoService httpTodoService = HttpTodoService();
