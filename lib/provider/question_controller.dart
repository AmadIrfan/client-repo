import 'dart:collection';
import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:quizapp/model/option_data.dart';
import 'package:quizapp/provider/obs_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../model/quiz_model.dart';

import '../ui/quiz/edit_question_view.dart';
import '../utils/widgets.dart';
import 'data/FirebaseData.dart';

class QuestionController extends GetxController {
  TextEditingController questionController = TextEditingController();
  TextEditingController optionAController = TextEditingController();
  TextEditingController optionBController = TextEditingController();
  TextEditingController optionCController = TextEditingController();
  TextEditingController optionDController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController browseController =
      TextEditingController(text: 'Browse');

  RxBool isOption = true.obs;

  ValueNotifier<String> questionError = ValueNotifier('');
  ValueNotifier<String> imageError = ValueNotifier('');
  ValueNotifier<String> optionA = ValueNotifier('');
  ValueNotifier<String> optionB = ValueNotifier('');
  ValueNotifier<String> optionC = ValueNotifier('');
  ValueNotifier<String> optionD = ValueNotifier('');

  QuizModel? quizModel;
  RxBool isLoading = false.obs;
  final ObsController obsController;


  QuestionController(BuildContext context,this.obsController, {this.quizModel});

  BuildContext? context;


  changeAnswerType(bool type){



    if (type?!isOption.value:isOption.value) {

      if(type) {
        optionType(optionList[0]);
        obsController.answerValue(optionList[0]);
      }else{
        optionType(trueFalseOptionList[0]);
        obsController.answerValue(trueFalseOptionList[0]);
      }
      isOption(type);
    }
  }
  @override
  void onInit() {
    if (quizModel != null) {
      questionController.text = quizModel!.question!;
      imageController.text =
          (quizModel!.image == null) ? '' : quizModel!.image!;



      if(quizModel!.type == 1){

        print("a===${quizModel!.answer!}");
        isOption(false);
        optionType(quizModel!.answer!);
        obsController.answerValue(quizModel!.answer!);

      }else{
        optionAController.text = quizModel!.optionList![0];
        optionBController.text = quizModel!.optionList![1];
        optionCController.text = quizModel!.optionList![2];
        optionDController.text = quizModel!.optionList![3];
        isOption(true);
        obsController.answerValue(getAnswerPosition());
        optionType(getAnswerPosition());

      }

      refId(quizModel!.refId!);

    }else{
      obsController.answerValue(optionList[0]);
    }

    super.onInit();
  }

  String getFileExtension(String fileName) {
    try {
      return ".${fileName.split('.').last}";
    } catch (e) {
      return '';
    }
  }

  Future<String> uploadFile(XFile _image) async {
    try {
      final fileBytes = await _image.readAsBytes();
      var reference =
          FirebaseStorage.instance.ref().child("files/${_image.name}");

      UploadTask uploadTask = reference.putData(
          fileBytes,
          SettableMetadata(
              contentType:
                  "image/${getFileExtension(_image.name).replaceAll('.', '')}"));
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {
        print("complete=====true");
      }).catchError((error) {
        print("error=====$error");

return error;
      });
      String url = await taskSnapshot.ref.getDownloadURL();
      print("complete=====$url");

      return url;
    } catch (e) {
      print('error in uploading image for : ${e.toString()}');
      return '';
    }
  }

  RxInt refId = 1.obs;
  RxString optionType = 'A'.obs;

  editQuestion(String url,bool isBack, {required ObsController obsController}) async {
    String optionList = '';
    if (isOption.value) {
      OptionData optionData =  OptionData();
      optionData.optionA = optionAController.text;
      optionData.optionB = optionBController.text;
      optionData.optionC = optionCController.text;
      optionData.optionD = optionDController.text;

      optionList = jsonEncode(optionData);
    }
    FirebaseData.updateQuestion(
        list: optionList,
        question: questionController.text,
        answer: isOption.value?getAnswer():optionType.value,
        refId: refId.value,
        image: url,
        doc: quizModel!.id!,
        type: isOption.value?0:1,
        obsController: obsController,
        isBack: isBack,
        function: () {
          isLoading(false);
        });
  }

  bool validation() {
    List<String> list = [];
    list.add(optionAController.text);
    list.add(optionBController.text);
    list.add(optionCController.text);
    list.add(optionDController.text);

    if (isNotEmpty(questionController.text)) {
      if (isNotEmpty(imageController.text)) {
        if ( isOption.value) {
          if (isNotEmpty(optionAController.text)) {
            if (isNotEmpty(optionBController.text)) {
              if (isNotEmpty(optionCController.text)) {
                if (isNotEmpty(optionDController.text)) {
                  optionD.value = '';

                  List<String> list = [];
                  list.add(optionAController.text);
                  list.add(optionBController.text);
                  list.add(optionCController.text);
                  list.add(optionDController.text);

                  List<String> result =
                      LinkedHashSet<String>.from(list).toList();
                  print("distinctIds===${result.length}");

                  if (result.length < 4) {
                    showToast('Enter valid option..');
                  } else {
                    return true;
                  }
                } else {

                  showToast('Enter Option value..');
                }
                optionC.value = '';
              } else {

                showToast('Enter Option value..');
              }
              optionB.value = '';
            } else {

              showToast('Enter Option value..');
            }
            optionA.value = '';
          }
        } else {
          return true;

        }
        imageError.value = '';
      } else {

        showToast('Enter image..');
      }
      questionError.value = '';
    } else {
      questionError.value = '';
      showToast('Enter question..');
    }

    return false;
  }

  addQuestion(String url, ObsController obsController,) async {
    String optionList = '';
    if (isOption.value) {
      OptionData optionData =  OptionData();
      optionData.optionA = optionAController.text;
      optionData.optionB = optionBController.text;
      optionData.optionC = optionCController.text;
      optionData.optionD = optionDController.text;

      optionList = jsonEncode(optionData);
    }


      FirebaseData.addQuestion(
          list: optionList,
          question: questionController.text,
          answer: isOption.value ? getAnswer() : optionType.value,
          id: refId.value,
          image: url,
          type: isOption.value ? 0 : 1,
          obsController: obsController,
          function: () {
            isLoading(false);
          });

  }

  getAnswerPosition() {
    int i = quizModel!.optionList!.indexOf(quizModel!.answer!.trim());

    if (i < 0) {
      i = 0;
    }
    return optionList[i];
  }

  getAnswer() {
    print("optionType==$optionType");
    if (optionType.value == 'A') {
      return optionAController.text;
    } else if (optionType.value == 'B') {
      return optionBController.text;
    } else if (optionType.value == 'C') {
      return optionCController.text;
    } else {
      return optionDController.text;
    }
  }
}
