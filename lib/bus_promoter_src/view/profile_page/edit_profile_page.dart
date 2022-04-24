import 'dart:io';
import 'package:bus_driver/bus_promoter_src/view/profile_page/promoter_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../common_src/constants/app_colors.dart';
import '../../../common_src/constants/network_constants.dart';
import '../../../common_src/data/network_service.dart';
import '../../../common_src/data/repository.dart';
import '../../../common_src/widget/profile_widget.dart';
import '../../data/models/edit_profile_credentials.dart';
import '../../data/models/edit_profile_dto.dart';
import '../../data/models/user_profile_dto.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({Key? key, required this.profileInformation}) : super(key: key);
  ProfileInformation profileInformation;
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final Repository repository;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    repository = Repository(networkService: NetworkService());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SimpleFontelicoProgressDialog _dialog = SimpleFontelicoProgressDialog(context: context, barrierDimisable:  false);
    nameController.text = widget.profileInformation.name?? '';
    emailController.text = widget.profileInformation.email?? '';
    final _formKey = GlobalKey<FormState>();

    return MaterialApp(
      // title: _title,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //  appBar: AppBar(title: const Text(_title)),
          body: SafeArea(
            child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5, top: 30, bottom: 30),
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    physics: BouncingScrollPhysics(),
                    children: [
                      ProfileWidget(
                        imagePath: '${NetworkConstants().baseUrl}${widget.profileInformation.image}',
                        isEdit: true,
                        onClicked: () async {
                          _showImageSelectionBottomSheet(context);
                        },
                      ),
                      const SizedBox(height: 24),
                      Container(padding: const EdgeInsets.all(10), child: TextFormField(
                        textInputAction: TextInputAction.next,
                        style: TextStyle(color: Colors.black),
                        controller: nameController, keyboardType: TextInputType.name, decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Name', prefixIcon: Icon(Icons.title)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name is required!';
                          }
                          return null;
                        },
                      ),),
                      const SizedBox(height: 24),
                      Container(padding: const EdgeInsets.all(10), child: TextFormField(
                        textInputAction: TextInputAction.done,
                        style: TextStyle(color: Colors.black),
                        controller: emailController, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Email', prefixIcon: Icon(Icons.email)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required!';
                          }
                          return null;
                        },
                      ),),
                      const SizedBox(height: 30),
                      Container(height: 120, padding: const EdgeInsets.only(top: 60, bottom: 10, left: 10, right: 10), child: ElevatedButton(
                        child: const Text('Save', style: TextStyle(fontSize: 20),),
                        onPressed: ()  {
                          if (_formKey.currentState!.validate()) {
                            _dialog.show(message: 'Please wait...',textStyle: TextStyle(color: AppColors.rainBlueLight));
                            final editProfileCredentials = EditProfileCredentials(name: nameController.text, email: emailController.text);
                            repository.editUserProfile(editProfileCredentials).then((response) {
                              if (response != null) {
                                if(response is EditProfileDTO){
                                  Fluttertoast.showToast(msg: "Profile updated successfully!", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: AppColors.rainBlueLight, textColor: Colors.white, fontSize: 16.0);
                                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => PromoterProfilePage()),(route) => route.settings.name == "EditProfilePage");
                                //  Navigator.of(context).popUntil((route) => route.settings.name == "EditProfilePage");
                                }
                              }else{
                                Navigator.of(_dialog.context!,rootNavigator: true).pop();
                                Fluttertoast.showToast(msg: "Something wrong!", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: AppColors.rainBlueLight, textColor: Colors.white, fontSize: 16.0);
                              }
                            });
                          }
                          },
                      )
                      ),
                    ],
                  ),
                )
            ),
          )
      ),
    );
  }

  _showImageSelectionBottomSheet(BuildContext context) {
   // late Reference ref;
    File? file = null;
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
                padding: EdgeInsets.all(20),
                height: 210,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Select image from", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: AppColors.rainBlueLight),),
                    Spacer(flex: 4,),
                    InkWell(
                      onTap: () async {
                        var picked = await ImagePicker().pickImage(source: ImageSource.gallery);
                        if (picked != null) {
                          file = File(picked.path);
                          print('Selected image path from Gallery is: $file');
                         // var rand = Random().nextInt(100000);
                         // var imagename = "$rand" + basename(picked.path);
                          //ref = FirebaseStorage.instance.ref(getImageRef(imageType)).child("$imagename");
                          /*
                          AlertDialog dialog = loadingAlertDialog();
                          showDialog(context: context, builder: (context){
                            dialogContext = context;
                            return dialog;
                          });
                          */
                          /*
                          await ref.putFile(file!);
                          await ref.getDownloadURL().then((value) {
                            setState(() {
                              if(imageType == ICON_TYPE) news!.icon = value;
                              else news!.image = value;
                            });
                          });
*/
                          /*
                          Navigator.pop(dialogContext!);
                          Navigator.of(context).pop();
                          */
                        }
                      },
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Icon(Icons.photo_outlined, size: 30, color: AppColors.rainBlueLight,),
                              SizedBox(width: 20),
                              Text("Gallery", style: TextStyle(fontSize: 20, color: AppColors.rainBlueLight),)
                            ],
                          )),
                    ),
                    Divider(color: Colors.grey,),
                    InkWell(
                      onTap: () async {
                        var picked = await ImagePicker().pickImage(source: ImageSource.camera);
                        if (picked != null) {
                          file = File(picked.path);
                          print('Selected image path from Camera is: $file');
                          /*
                          var rand = Random().nextInt(100000);
                          var imagename = "$rand" + basename(picked.path);
                          ref = FirebaseStorage.instance.ref(getImageRef(imageType)).child("$imagename");
                          AlertDialog dialog = loadingAlertDialog();
                          showDialog(context: context, builder: (context){
                            dialogContext = context;
                            return dialog;
                          });
                          await ref.putFile(file!);
                          await ref.getDownloadURL().then((value) {
                            setState(() {
                              if(imageType == ICON_TYPE) news!.icon = value;
                              else news!.image = value;
                            });
                          });
                          Navigator.pop(dialogContext!);
                          Navigator.of(context).pop();
                        */
                        }
                      },
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Icon(Icons.camera, size: 30, color: AppColors.rainBlueLight,),
                              SizedBox(width: 20),
                              Text("Camera", style: TextStyle(fontSize: 20, color: AppColors.rainBlueLight),)
                            ],
                          )),
                    ),
                  ],
                ),
              );
        });
  }
}