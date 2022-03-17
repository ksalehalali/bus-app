import 'dart:convert';
import 'package:bus_driver/bus_driver_src/constants/network_constants.dart';
import 'package:http/http.dart';
import '../helper/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NetworkService {
  late final AppData _appData = AppData();

  /*
  Future<List<dynamic>> fetchTodos() async {
    try {
      final response = await get(Uri.parse(baseUrl + "/todos"));
      print(response.body);
      return jsonDecode(response.body) as List;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<bool> patchTodo(Map<String, String> patchObj, int id) async {
    try {

      await patch(Uri.parse(baseUrl + "/todos/$id"), body: patchObj);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Map> addTodo(Map<String, String> todoObj) async {
    try {
      final response = await post(Uri.parse(baseUrl + "/todos"), body: todoObj);
      return jsonDecode(response.body);
    } catch (e) {
      return null;
    }
  }

  Future<bool> deleteTodo(int id) async {
    try {
      await delete(Uri.parse(baseUrl + "/todos/$id"));
      return true;
    } catch (er) {
      return false;
    }
  }
*/

  Future<Map?> login(Map<String, dynamic> loginCredentialsJson) async {
    try {
      final response = await post(Uri.parse(NetworkConstants().baseUrl + "/Login"), headers: NetworkConstants().headers, body: jsonEncode(loginCredentialsJson));
      return jsonDecode(response.body);
    } catch (e) {
      print("loginResponseDTO error: ${e.toString()}");
      return null;
    }
  }

  Future<Map?> driverEnter(Map<String, dynamic> driverEnterCredentialsJson)  async {
    try {
      SharedPreferences? pref =  await _appData.getSharedPreferencesInstance();
      String accessToken = _appData.getAccessToken(pref!)!;
      Map<String, String> headers = NetworkConstants().headers;
      headers['Authorization'] = accessToken;
      final response = await post(Uri.parse(NetworkConstants().baseUrl + "/DriverEnter"), headers: headers, body: jsonEncode(driverEnterCredentialsJson));
      print("DriverEnterOutResponseDTO...Enter request: ${response.request}, response: ${response.body}");
      return jsonDecode(response.body);
    } catch (e) {
      print("DriverEnterOutResponseDTO error: ${e.toString()}");
      return null;
    }
  }

  Future<Map?> driverOut(Map<String, dynamic> driverOutCredentialsJson) async {
    try {
      SharedPreferences? pref =  await _appData.getSharedPreferencesInstance();
      String accessToken = _appData.getAccessToken(pref!)!;
      Map<String, String> headers = NetworkConstants().headers;
      headers['Authorization'] = accessToken;
      final response = await post(Uri.parse(NetworkConstants().baseUrl + "/DriverOut"), headers: headers, body: jsonEncode(driverOutCredentialsJson));
      print("DriverEnterOutResponseDTO...Out request: ${response.request}, response: ${response.body}");
      return jsonDecode(response.body);
    } catch (e) {
      print("DriverEnterOutResponseDTO error: ${e.toString()}");
      return null;
    }
  }
}