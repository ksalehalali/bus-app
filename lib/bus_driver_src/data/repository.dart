import 'models/driver_enter_credentials.dart';
import 'models/driver_enter_out_response_dto.dart';
import 'models/driver_out_credentials.dart';
import 'models/login_credentials.dart';
import 'models/login_error_response_dto.dart';
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

  Future<dynamic?> login(LoginCredentials loginCredentials) async {
  //  final todoObj = { "todo": message, "isCompleted": "false" };

    final todoMap = await networkService.login(loginCredentials.toJson());
    if (todoMap == null) return null;

    if(todoMap['status'] == true){
      return LoginResponseDTO.fromJson(todoMap);
    }else{
      return LoginErrorResponseDTO.fromJson(todoMap);
    }
  }

  Future<dynamic?> driverEnter(DriverEnterCredentials driverEnterCredentials) async {
    final todoMap = await networkService.driverEnter(driverEnterCredentials.toJson());
     // print("DriverEnterOutResponseDTO todoMap: ${todoMap}");
      if (todoMap == null) return null;

      if(todoMap['status'] == true){
        return DriverEnterOutResponseDTO.fromJson(todoMap);
      }

  }

  Future<dynamic?> driverOut(DriverOutCredentials driverOutCredentials) async {
    final todoMap = await networkService.driverOut(driverOutCredentials.toJson());
    if (todoMap == null) return null;

    if(todoMap['status'] == true){
      return DriverEnterOutResponseDTO.fromJson(todoMap);
    }
  }
}