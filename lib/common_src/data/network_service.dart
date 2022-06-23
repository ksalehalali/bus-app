import 'dart:convert';
import 'dart:io';
import 'package:bus_driver/Inspector_Controllers/current_data.dart';
import 'package:http/http.dart';
import '../../bus_driver_src/helper/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/network_constants.dart';
import 'package:http/http.dart' as http;

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
      final response = await post(Uri.parse(NetworkConstants().baseApiUrl + "/Login"), headers: NetworkConstants().headers, body: jsonEncode(loginCredentialsJson));
      //myToken = response.body['description']['token'];

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
      final response = await post(Uri.parse(NetworkConstants().baseApiUrl + "/DriverEnter"), headers: headers, body: jsonEncode(driverEnterCredentialsJson));
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
      final response = await post(Uri.parse(NetworkConstants().baseApiUrl + "/DriverOut"), headers: headers, body: jsonEncode(driverOutCredentialsJson));
      print("DriverEnterOutResponseDTO...Out request: ${response.request}, response: ${response.body}");
      return jsonDecode(response.body);
    } catch (e) {
      print("DriverEnterOutResponseDTO error: ${e.toString()}");
      return null;
    }
  }

  Future<Map?> getBusInformation(Map<String, dynamic> busInformationCredentialsJson) async {
    try {
      SharedPreferences? pref =  await _appData.getSharedPreferencesInstance();
      String accessToken = _appData.getAccessToken(pref!)!;
      Map<String, String> headers = NetworkConstants().headers;
      headers['Authorization'] = accessToken;
      final response = await post(Uri.parse(NetworkConstants().baseApiUrl + "/GetBus"), headers: headers, body: jsonEncode(busInformationCredentialsJson));
      print("BusInformationResponseDTO... request: ${response.request}, response: ${response.body}");
      return jsonDecode(response.body);
    } catch (e) {
      print("BusInformationResponseDTO error: ${e.toString()}");
      return null;
    }
  }

  Future<Map?> getListPaymentWalletByBus(Map<String, dynamic> listPaymentWalletByBusCredentialsJson) async {
    try {
      SharedPreferences? pref =  await _appData.getSharedPreferencesInstance();
      String accessToken = _appData.getAccessToken(pref!)!;
      Map<String, String> headers = NetworkConstants().headers;
      headers['Authorization'] = accessToken;
      final response = await post(Uri.parse(NetworkConstants().baseApiUrl + "/ListPaymentWalletByBus"), headers: headers, body: jsonEncode(listPaymentWalletByBusCredentialsJson));
      print("ListPaymentWalletByBusDTO... request: ${response.request}, response: ${response.body}");
      return jsonDecode(response.body);
    } catch (e) {
      print("ListPaymentWalletByBusDTO error: ${e.toString()}");
      return null;
    }
  }

  Future<Map?> getUserProfile() async {
    try {
      SharedPreferences? pref =  await _appData.getSharedPreferencesInstance();
      String accessToken = _appData.getAccessToken(pref!)!;
      Map<String, String> headers = NetworkConstants().headers;
      headers['Authorization'] = accessToken;
      final response = await get(Uri.parse(NetworkConstants().baseApiUrl + "/MyProfile"), headers: headers);
      print("UserProfileDTO... request: ${response.request}, response: ${response.body}");
      return jsonDecode(response.body);
    } catch (e) {
      print("UserProfileDTO error: ${e.toString()}");
      return null;
    }
  }

  Future<Map?> getInstallationListByPromoter(Map<String, dynamic> installationListByPromoterCredentialsJson) async {
    try {
      SharedPreferences? pref =  await _appData.getSharedPreferencesInstance();
      String accessToken = _appData.getAccessToken(pref!)!;
      Map<String, String> headers = NetworkConstants().headers;
      headers['Authorization'] = accessToken;
      final response = await post(Uri.parse(NetworkConstants().baseApiUrl + "/ListPromoterInstallationByPromoter"), headers: headers, body: jsonEncode(installationListByPromoterCredentialsJson));
      print("InstallationListByPromoterDTO... request: ${response.request}, body: ${jsonEncode(installationListByPromoterCredentialsJson)}, response: ${response.body}");
      return jsonDecode(response.body);
    } catch (e) {
      print("InstallationListByPromoterDTO error: ${e.toString()}");
      return null;
    }
  }

  Future<Map?> editUserProfile(Map<String, dynamic> editProfileCredentialsJson) async {
    try {
      SharedPreferences? pref =  await _appData.getSharedPreferencesInstance();
      String accessToken = _appData.getAccessToken(pref!)!;
      Map<String, String> headers = NetworkConstants().headers;
      headers['Authorization'] = accessToken;
      final response = await post(Uri.parse(NetworkConstants().baseApiUrl + "/EditeUser"), headers: headers, body: jsonEncode(editProfileCredentialsJson));
      return jsonDecode(response.body);
    } catch (e) {
      print("EditProfileDTO error: ${e.toString()}");
      return null;
    }
  }

  /*
  Future<Map?> editUserProfileImage(Map<String, dynamic> editProfileImageJsonBody) async {
    try {
      SharedPreferences? pref =  await _appData.getSharedPreferencesInstance();
      String accessToken = _appData.getAccessToken(pref!)!;
      Map<String, String> headers = NetworkConstants().headers;
      headers['Authorization'] = accessToken;
      final response = await post(Uri.parse(NetworkConstants().baseApiUrl + "/EditeImage"), headers: headers, body: editProfileImageJsonBody);
      return jsonDecode(response.body);
    } catch (e) {
      print("EditProfileImageDTO error: ${e.toString()}");
      return null;
    }
  }
*/

  Future<Map?> editUserProfileImage(File editedImage) async {
    final url = Uri.parse(NetworkConstants().baseApiUrl + "/EditeImage");
    SharedPreferences? pref =  await _appData.getSharedPreferencesInstance();
    String accessToken = _appData.getAccessToken(pref!)!;
    var request = http.MultipartRequest('POST', url);
    request.headers['Content-type'] ='multipart/form-data';
    request.headers['Authorization'] = accessToken;

    print("${editedImage.path}");

    request.files.add(
      http.MultipartFile('Image',
          File(editedImage.path).readAsBytes().asStream(),
          File(editedImage.path).lengthSync(),
          filename: editedImage.path.split("/").last),
    );

    try {
      var response = await request.send();
      final res = await http.Response.fromStream(response);
      print("ressss: ${res.body.toString()}" );
      print("${res.statusCode}");

    //  Map<String, dynamic> dep = jsonDecode(utf8.decode(res.bodyBytes));

      return jsonDecode(res.body);
    }
    catch(e) {
      print("EditProfileImageDTO error: ${e.toString()}");
      return null;
    }
  }

  Future<Map?> getUserWallet() async {
    try {
      SharedPreferences? pref =  await _appData.getSharedPreferencesInstance();
      String accessToken = _appData.getAccessToken(pref!)!;
      Map<String, String> headers = NetworkConstants().headers;
      headers['Authorization'] = accessToken;
      final response = await get(Uri.parse(NetworkConstants().baseApiUrl + "/GetWallet"), headers: headers);
      print("WalletDTO... request: ${response.request}, response: ${response.body}");
      return jsonDecode(response.body);
    } catch (e) {
      print("WalletDTO error: ${e.toString()}");
      return null;
    }
  }

  Future<Map?> getUserIncomingWalletList(Map<String, dynamic> userIncomingWalletCredentialsJson) async {
    try {
      SharedPreferences? pref =  await _appData.getSharedPreferencesInstance();
      String accessToken = _appData.getAccessToken(pref!)!;
      Map<String, String> headers = NetworkConstants().headers;
      headers['Authorization'] = accessToken;
      final response = await post(Uri.parse(NetworkConstants().baseApiUrl + "/ListChrgingWalletByUser"), headers: headers, body: jsonEncode(userIncomingWalletCredentialsJson));
      print("UserIncomingWalletDTO... request: ${response.request}, response: ${response.body}");
      return jsonDecode(response.body);
    } catch (e) {
      print("UserIncomingWalletDTO error: ${e.toString()}");
      return null;
    }
  }

  Future<Map?> getPromoterOutgoingWalletList(Map<String, dynamic> promoterOutgoingWalletCredentialsJson) async {
    try {
      SharedPreferences? pref =  await _appData.getSharedPreferencesInstance();
      String accessToken = _appData.getAccessToken(pref!)!;
      Map<String, String> headers = NetworkConstants().headers;
      headers['Authorization'] = accessToken;
      final response = await post(Uri.parse(NetworkConstants().baseApiUrl + "/ListCharcheByPromoter"), headers: headers, body: jsonEncode(promoterOutgoingWalletCredentialsJson));
      print("PromoterOutgoingWalletDTO... request: ${response.request}, response: ${response.body}");
      return jsonDecode(response.body);
    } catch (e) {
      print("PromoterOutgoingWalletDTO error: ${e.toString()}");
      return null;
    }
  }

  Future<Map?> chargeUserWallet(Map<String, dynamic> chargeUserWalletCredentialsJson) async {
    try {
      SharedPreferences? pref =  await _appData.getSharedPreferencesInstance();
      String accessToken = _appData.getAccessToken(pref!)!;
      Map<String, String> headers = NetworkConstants().headers;
      headers['Authorization'] = accessToken;
      final response = await post(Uri.parse(NetworkConstants().baseApiUrl + "/ChargeWalletByPromoter"), headers: headers, body: jsonEncode(chargeUserWalletCredentialsJson));
      print("ChargeUserWalletDTO... request: ${response.request}, body: ${jsonEncode(chargeUserWalletCredentialsJson)}, response: ${response.body}");
      return jsonDecode(response.body);
    } catch (e) {
      print("ChargeUserWalletDTO error: ${e.toString()}");
      return null;
    }
  }

  Future<Map?> chargeMyWallet(Map<String, dynamic> chargeUserWalletCredentialsJson) async {
    try {
      SharedPreferences? pref =  await _appData.getSharedPreferencesInstance();
      String accessToken = _appData.getAccessToken(pref!)!;
      Map<String, String> headers = NetworkConstants().headers;
      headers['Authorization'] = accessToken;
      final response = await post(Uri.parse(NetworkConstants().baseApiUrl + "/ChargeMyWallet"), headers: headers, body: jsonEncode(chargeUserWalletCredentialsJson));
      print("ChargeMyWalletDTO... request: ${response.request}, body: ${jsonEncode(chargeUserWalletCredentialsJson)}, response: ${response.body}");
      return jsonDecode(response.body);
    } catch (e) {
      print("ChargeMyWalletDTO error: ${e.toString()}");
      return null;
    }
  }
}