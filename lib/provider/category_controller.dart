

import 'package:flutter/cupertino.dart';
import 'package:quizapp/model/topic_model.dart';
import 'package:quizapp/provider/obs_controller.dart';
import 'package:quizapp/utils/Constants.dart';
import 'package:get/get.dart';


import '../utils/widgets.dart';
import 'data/FirebaseData.dart';

class CategoryController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController refIdController = TextEditingController();

  TopicModel? topicModel;
  RxBool isLoading = false.obs;

  CategoryController({this.topicModel});

  @override
  void onInit() {
    super.onInit();

    if (topicModel != null) {
      nameController.text = topicModel!.title!;
    }
  }

  addCategory(ObsController obsController) async {
    int i = await FirebaseData.getRefId();
    if (isNotEmpty(nameController.text)) {
      isLoading(true);
      FirebaseData.addCategory(
          name: nameController.text,
          refId: i,
          obsController: obsController,
          function: () {
            isLoading(false);
          });
    } else {
      showToast('Enter name..');
    }
  }

  updateCategory(ObsController obsController) async {
    if (isNotEmpty(nameController.text)) {
      isLoading(true);
      FirebaseData.editCategory(
          name: nameController.text,
          id: topicModel!.id!,
          function: () {
            isLoading(false);
            obsController.index(Constants.categoryView);
          });
    } else {
      showToast('Enter name..');
    }
  }
}
