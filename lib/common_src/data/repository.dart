import 'dart:io';
import '../../bus_driver_src/data/models/bus_information_dto.dart';
import '../../bus_driver_src/data/models/bus_information_credentials.dart';
import '../../bus_driver_src/data/models/driver_enter_credentials.dart';
import '../../bus_driver_src/data/models/driver_enter_out_response_dto.dart';
import '../../bus_driver_src/data/models/driver_out_credentials.dart';
import '../../bus_driver_src/data/models/list_payment_wallet_by_bus_credentials.dart';
import '../../bus_driver_src/data/models/list_payment_wallet_by_bus_dto.dart';
import '../../bus_promoter_src/data/models/charge_my_wallet_credentials.dart';
import '../../bus_promoter_src/data/models/charge_my_wallet_dto.dart';
import '../../bus_promoter_src/data/models/charge_user_wallet_credentials.dart';
import '../../bus_promoter_src/data/models/charge_user_wallet_dto.dart';
import '../../bus_promoter_src/data/models/edit_profile_credentials.dart';
import '../../bus_promoter_src/data/models/edit_profile_dto.dart';
import '../../bus_promoter_src/data/models/edit_profile_image_dto.dart';
import '../../bus_promoter_src/data/models/promoter_outgoing_wallet_credentials.dart';
import '../../bus_promoter_src/data/models/promoter_outgoing_wallet_dto.dart';
import '../../bus_promoter_src/data/models/user_incoming_wallet_credentials.dart';
import '../../bus_promoter_src/data/models/user_incoming_wallet_dto.dart';
import '../../bus_promoter_src/data/models/user_profile_dto.dart';
import 'models/login_credentials.dart';
import 'models/login_error_response_dto.dart';
import 'models/login_response_dto.dart';
import 'models/wallet_dto.dart';
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

  Future<dynamic?> getBusInformation(BusInformationCredentials busInformationCredentials) async {
    final todoMap = await networkService.getBusInformation(busInformationCredentials.toJson());
    if (todoMap == null) return null;
    if(todoMap['status'] == true){
      return BusInformationResponseDTO.fromJson(todoMap);
    }
  }

  Future<dynamic?> getListPaymentWalletByBus(ListPaymentWalletByBusCredentials listPaymentWalletByBusCredentials) async {
    final todoMap = await networkService.getListPaymentWalletByBus(listPaymentWalletByBusCredentials.toJson());
    if (todoMap == null) return null;
    if(todoMap['status'] == true){
      return ListPaymentWalletByBusDTO.fromJson(todoMap);
    }
  }

  Future<dynamic?> getUserProfile() async {
    final todoMap = await networkService.getUserProfile();
    if (todoMap == null) return null;
    if(todoMap['status'] == true){
      return UserProfileDTO.fromJson(todoMap);
    }
  }

  Future<dynamic?> editUserProfile(EditProfileCredentials editProfileCredentials) async {
    final todoMap = await networkService.editUserProfile(editProfileCredentials.toJson());
    if (todoMap == null) return null;
    if(todoMap['status'] == true){
      return EditProfileDTO.fromJson(todoMap);
    }
  }

  Future<dynamic?> editUserProfileImage(File editedImage) async {
   /*
    request.files.add(
      http.MultipartFile('Image',
          File(editedImage.path).readAsBytes().asStream(),
          File(editedImage.path).lengthSync(),
          filename: editedImage.path.split("/").last),
    );
*/
    /*
    var map = new Map<String, dynamic>();
    map['Image'] = imageUrl.toString();
    */
    final todoMap = await networkService.editUserProfileImage(editedImage);
    if (todoMap == null) return null;
    if(todoMap['status'] == true){
      return EditProfileImageDTO.fromJson(todoMap);
    }
  }

  Future<dynamic?> getUserWallet() async {
    final todoMap = await networkService.getUserWallet();
    if (todoMap == null) return null;
    if(todoMap['status'] == true){
      return WalletDTO.fromJson(todoMap);
    }
  }

  Future<dynamic?> getUserIncomingWalletList(UserIncomingWalletCredentials userIncomingWalletCredentials) async {
    final todoMap = await networkService.getUserIncomingWalletList(userIncomingWalletCredentials.toJson());
    if (todoMap == null) return null;
    if(todoMap['status'] == true){
      return UserIncomingWalletDTO.fromJson(todoMap);
    }
  }

  Future<dynamic?> getPromoterOutgoingWalletList(PromoterOutgoingWalletCredentials promoterOutgoingWalletCredentials) async {
    final todoMap = await networkService.getPromoterOutgoingWalletList(promoterOutgoingWalletCredentials.toJson());
    if (todoMap == null) return null;
    if(todoMap['status'] == true){
      return PromoterOutgoingWalletDTO.fromJson(todoMap);
    }
  }

  Future<dynamic?> chargeUserWallet(ChargeUserWalletCredentials chargeUserWalletCredentials) async {
    final todoMap = await networkService.chargeUserWallet(chargeUserWalletCredentials.toJson());
    if (todoMap == null) return null;
    if(todoMap['status'] == true){
      return ChargeUserWalletDTO.fromSuccessJson(todoMap);
    }else if(todoMap['status'] == false){
      return ChargeUserWalletDTO.fromFailedJson(todoMap);
    }
  }

  Future<dynamic?> chargeMyWallet(ChargeMyWalletCredentials chargeMyWalletCredentials) async {
    final todoMap = await networkService.chargeMyWallet(chargeMyWalletCredentials.toJson());
    if (todoMap == null) return null;
    if(todoMap['status'] == true){
      return ChargeMyWalletDTO.fromSuccessJson(todoMap);
    }else if(todoMap['status'] == false){
      return ChargeMyWalletDTO.fromFailedJson(todoMap);
    }
  }
}