

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizapp/model/admin_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


import '../utils/pref_data.dart';
import 'data/FirebaseData.dart';

class ProfileController extends GetxController {


  RxString imageUrl =''.obs;
  RxString username =''.obs;

  @override
  void onInit() {
    getProfileImage();

    super.onInit();
  }

  getProfileImage() async {
    String id = await PrefData.getUserId();

    DocumentSnapshot? querySnapshot = await FirebaseFirestore.instance
        .collection(FirebaseData.adminData)
        .doc(id)
        .get();

    print("querySnapshot==${querySnapshot.data()}");


    if(querySnapshot.data() == null){
      PrefData.setLogin(false,'',false);
    }


    AdminModel adminModel = AdminModel.fromFirestore(querySnapshot);
    username(adminModel.username!);
    imageUrl(adminModel.image!);
    update();
  }


  imgFromGallery() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if(image!=null) {

    }
  }





}
