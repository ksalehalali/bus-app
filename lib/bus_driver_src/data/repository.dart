
import 'models/login_credentials.dart';
import 'models/login_response_dto.dart';
import 'network_service.dart';

class Repository {

  final NetworkService networkService;

  Repository({required this.networkService});

  /*
  Future<List<Todo>> fetchTodos() async {
    final todosRaw = await networkService.fetchTodos();
    return todosRaw.map((e) => Todo.fromJson(e)).toList();
  }

  Future<bool> changeCompletion(bool isCompleted, int id) async {
    final patchObj = { "isCompleted": isCompleted.toString() };
    return await networkService.patchTodo(patchObj, id);
  }

  Future<Todo> addTodo(String message) async {
    final todoObj = { "todo": message, "isCompleted": "false" };

    final todoMap = await networkService.addTodo(todoObj);
    if (todoMap == null) return null;

    return Todo.fromJson(todoMap);
  }

  Future<bool> deleteTodo(int id) async {
    return await networkService.deleteTodo(id);
  }

  Future<bool> updateTodo(String message, int id) async {
    final patchObj = { "todo": message };
    return await networkService.patchTodo(patchObj, id);
  }
*/

  Future<LoginResponseDTO?> login(LoginCredentials loginCredentials) async {
  //  final todoObj = { "todo": message, "isCompleted": "false" };

    final todoMap = await networkService.login(loginCredentials.toJson());
    if (todoMap == null) return null;

    return LoginResponseDTO.fromJson(todoMap);
  }
}