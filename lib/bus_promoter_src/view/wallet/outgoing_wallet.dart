import 'package:bus_driver/bus_promoter_src/view/wallet/wallet_item_widget.dart';
import 'package:flutter/material.dart';
import '../../../common_src/constants/app_colors.dart';
import '../../../common_src/data/network_service.dart';
import '../../../common_src/data/repository.dart';
import '../../data/models/promoter_outgoing_wallet_credentials.dart';
import '../../data/models/promoter_outgoing_wallet_dto.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OutgoingWallet extends StatefulWidget {
  OutgoingWallet({Key? key}) : super(key: key);

  @override
  _OutgoingWallet createState() => _OutgoingWallet();
}

class _OutgoingWallet extends State<OutgoingWallet> with AutomaticKeepAliveClientMixin<OutgoingWallet>{
  List<Color> currentGradientColors = AppColors.activeGradient;
  List<OutgoingWalletItem> outgoingWalletItems = [];
  List<Widget> outgoingWalletItemWidgets = [];
  ListView? _listView;
  late final Repository _repository;
  
  @override
  void initState() {
    getOutgoingWalletList();
    super.initState();
  }

  void getOutgoingWalletList(){
    _repository = Repository(networkService: NetworkService());
    final promoterOutgoingWalletCredentials = PromoterOutgoingWalletCredentials(pageNumber: '1', pageSize: '500');
    _repository.getPromoterOutgoingWalletList(promoterOutgoingWalletCredentials).then((response) async{
      if (response != null) {
        if(response.status == true){
          try {
            PromoterOutgoingWalletDTO promoterOutgoingWalletDTO = response as PromoterOutgoingWalletDTO;
            if(promoterOutgoingWalletDTO.outgoingWalletItems != null && promoterOutgoingWalletDTO.outgoingWalletItems!.isNotEmpty){
              promoterOutgoingWalletDTO.outgoingWalletItems!.toList().forEach((element) { outgoingWalletItemWidgets.add(WalletItemWidget(false, element.user, element.value.toString(), element.time)); });

              setState(() {
                _listView = ListView(children: outgoingWalletItemWidgets,);
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

  @override
  bool get wantKeepAlive => true;
}