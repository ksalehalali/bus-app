import 'package:bus_driver/bus_promoter_src/view/wallet/wallet_item_widget.dart';
import 'package:flutter/material.dart';
import '../../../common_src/constants/app_colors.dart';
import '../../../common_src/data/network_service.dart';
import '../../../common_src/data/repository.dart';
import '../../data/models/user_incoming_wallet_credentials.dart';
import '../../data/models/user_incoming_wallet_dto.dart';
import 'package:fluttertoast/fluttertoast.dart';

class IncomingWallet extends StatefulWidget {
  IncomingWallet({Key? key}) : super(key: key);

  @override
  _IncomingWallet createState() => _IncomingWallet();
}

class _IncomingWallet extends State<IncomingWallet> {
  List<Color> currentGradientColors = AppColors.activeGradient;
  List<IncomingWalletItem> incomingWalletItems = [];
  List<Widget> incomingWalletItemWidgets = [];
  ListView? _listView;
  late final Repository _repository;

  @override
  void initState() {
    getIncomingWalletList();
    super.initState();
  }

  void getIncomingWalletList(){
    _repository = Repository(networkService: NetworkService());
      final userIncomingWalletCredentials = UserIncomingWalletCredentials(pageNumber: 1, pageSize: 500);
      _repository.getUserIncomingWalletList(userIncomingWalletCredentials).then((response) async{
        if (response != null) {
          if(response.status == true){
            try {
              UserIncomingWalletDTO userIncomingWalletDTO = response as UserIncomingWalletDTO;
              if(userIncomingWalletDTO.incomingWalletItem != null && userIncomingWalletDTO.incomingWalletItem!.isNotEmpty){
                userIncomingWalletDTO.incomingWalletItem!.toList().forEach((element) { incomingWalletItemWidgets.add(WalletItemWidget(true, element.paymentGateway.toString(), element.value.toString(), element.time)); });

                setState(() {
                  _listView = ListView(children: incomingWalletItemWidgets ,);
                });
              }
            }catch(e){
              Fluttertoast.showToast(msg: "Something wrong!..", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
            }
          }else{
            Fluttertoast.showToast(msg: "Something wrong!", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
          }
        }else{
          Fluttertoast.showToast(msg: "Something wrong!", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
        }
      });
  }
  
  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child: _listView),);
  }
}