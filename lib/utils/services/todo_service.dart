import '../networking/http_client.dart';

abstract class AbstractTodoService {
  dynamic getTodos() {}
}

class HttpTodoService implements AbstractTodoService {
  @override
  dynamic getTodos() async {
    try {
      dynamic todos =
          await appClient.get('https://jsonplaceholder.typicode.com/todos');
      return todos;
    } on Exception catch (error) {
      print(error);
      rethrow;
    }
  }
}

HttpTodoService httpTodoService = HttpTodoService();
