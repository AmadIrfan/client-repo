import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizapp/model/category_data.dart';
import 'package:quizapp/model/question_data.dart';
import 'package:quizapp/provider/data/LoginData.dart';
import 'package:quizapp/provider/obs_controller.dart';
import 'package:quizapp/utils/Constants.dart';
import 'package:quizapp/utils/pref_data.dart';
import 'package:get/get.dart';

import '../../model/quiz_model.dart';
import '../../model/topic_model.dart';
import '../../utils/app_routes.dart';
import '../../utils/widgets.dart';

class FirebaseData {
  static String topicList = 'topic_list';
  static String quizList = 'quizData';
  static String historyList = 'historyData';
  static String dataList = 'data';
  static String detailList = 'dataList';
  static String coinData = 'coinData';
  static String adminData = 'admin';
  static String loginData = 'loginData';
  static String refId = 'ref_id';
  static String index = 'index';
  // static String timeStamp = 'timeStamp';
  static String keyActive = 'active';
  static String keyImage = 'image';
  static String keyPassword = 'password';
  static String keyUsername = 'username';
  static String keyAdmin = 'is_admin';


  static createUser(
      {
        required bool isAdmin,
        required String password,
        required String username,
        required Function function}) {



    FirebaseFirestore.instance.collection(FirebaseData.adminData).add({
      keyUsername:username,
      keyPassword:password,
      LoginData.keyUid:FirebaseAuth.instance.currentUser!.uid,
      keyAdmin:isAdmin
    }).then((value) {
      print("called-----function");
      function();
    });

  }


  static addQuestion(
      {required String list,
      required String question,
      required String answer,
      required int id,
      required int type,
      required String image,
      ObsController? obsController,
      required Function function}) async {

    int i= await getIndex();


    QuestionData questionData = new QuestionData();
    questionData.optionList = list;
    questionData.question = question;
    questionData.refId = id;
    questionData.answer = answer;
    questionData.image = image;
    questionData.type = type;
    questionData.index = i;
    FirebaseFirestore.instance
        .collection(quizList)
        .add(questionData.toJson(true))
        .then((value) async {

          print("add==true===${questionData.index}");
      showToast("Add Quiz Successfully...");
      if (obsController != null) {
        obsController.index(Constants.dashboardView);
      }
      String title = await getCategoryName(id);
      function();
      TopicModel topicModel = new TopicModel();
      topicModel.refId = id;
      topicModel.title = title;
      Get.toNamed(KeyUtil.quizList, arguments: topicModel);
    });
  }

  static Future<String> getCategoryName(int id) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(FirebaseData.topicList)
        .where(refId, isEqualTo: id)
        .get();

    if (querySnapshot.size > 0) {
      if (querySnapshot.docs.isNotEmpty) {
        List<DocumentSnapshot> list1 = querySnapshot.docs;
        if (list1.isNotEmpty) {
          TopicModel topicModel = TopicModel.fromFirestore(list1[0]);

          return (topicModel.title!);
        }
      }

      return '';
    } else {
      return '';
    }
  }

  static updateQuestion(
      {required String list,
      required String question,
      required String answer,
      required int refId,
      required int type,
      required String image,
      required String doc,
      required Function function,
      required bool isBack,
        required ObsController obsController}) async {
    QuestionData questionData = new QuestionData();
    questionData.optionList = list;
    questionData.question = question;
    questionData.refId = refId;
    questionData.answer = answer;
    questionData.image = image;
    questionData.type = type;
    FirebaseFirestore.instance
        .collection(quizList)
        .doc(doc)
        .update(questionData.toJson(false))
        .then((value) async {
      showToast("Edit Quiz Successfully...");

      if (!isBack) {
        obsController.index(Constants.allQuestion);
      } else {
        function();
        Get.back();
      }
    });
  }
  static Future<int> getRefId() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(FirebaseData.topicList)
        .orderBy('ref_id', descending: true)
        .get();
    if (querySnapshot.size > 0) {
      if (querySnapshot.docs.isNotEmpty) {
        List<DocumentSnapshot> list1 = querySnapshot.docs;
        if (list1.isNotEmpty) {
          TopicModel topicModel = TopicModel.fromFirestore(list1[0]);
          return (topicModel.refId! + 1);
        }
      }
      return 1;
    } else {
      return 1;
    }
  }

  static addCategory(
      {required String name,
      required int refId,
      ObsController? obsController,
      required Function function}) async {
    CategoryData firebaseHistory = new CategoryData();

    firebaseHistory.refId = (refId);
    firebaseHistory.name = name;
    FirebaseFirestore.instance
        .collection(topicList)
        .add(firebaseHistory.toJson())
        .then((value) {
      showToast("Add Successfully...");
      function();
      if (obsController != null) {
        print("obsController==$obsController");
        obsController.index(Constants.categoryView);
      }
    });
  }

  static editCategory(
      {required String name,
      required String id,
      required Function function}) async {
    FirebaseFirestore.instance
        .collection(topicList)
        .doc(id)
        .update({'title': name}).then((value) {
      showToast("Edit Successfully...");
      function();
    });
  }

  static editUser(
      {required String active,
      required String id,
      required Function function}) async {
    FirebaseFirestore.instance
        .collection(loginData)
        .doc(id)
        .update({keyActive: active}).then((value) {
      function();
    });
  }

  static deleteCategory(
      {required String id,
      required int refId,
      required Function function}) async {
    FirebaseFirestore.instance
        .collection(topicList)
        .doc(id)
        .delete()
        .then((value) {
      // function();
    });

    WriteBatch batch = FirebaseFirestore.instance.batch();

   QuerySnapshot querySnapshot=  await FirebaseFirestore.instance
        .collection(FirebaseData.quizList)
        .where(FirebaseData.refId, isEqualTo: refId)
        .get();

    if (querySnapshot.size > 0) {
      if (querySnapshot.docs.isNotEmpty) {
        List<DocumentSnapshot> list1 = querySnapshot.docs;
        for (int i = 0; i < list1.length; i++) {

        batch.delete(list1[i].reference);

        }
        batch.commit().then((value) {
          function();
        });
      }else{
        function();
      }
    }else{
      function();
    }
  }

  static deleteQuestion(
      {required String id, required Function function}) async {
    FirebaseFirestore.instance
        .collection(quizList)
        .doc(id)
        .delete()
        .then((value) {
      function();
    });
  }

  static deleteUser({required String id, required Function function}) async {
    FirebaseFirestore.instance
        .collection(loginData)
        .doc(id)
        .delete()
        .then((value) {
      function();
    });
  }

  static changePassword(
      {required String password, required Function function}) async {


if(FirebaseAuth.instance.currentUser !=null){

  User? user=   FirebaseAuth.instance.currentUser!;

  user.updatePassword(password).then((_) async {
    String id = await PrefData.getUserId();

    FirebaseFirestore.instance
        .collection(adminData)
        .doc(id)
        .update({'password': password}).then((value) {
      showToast("Password change successfully");
      function();
    });
  }).catchError((error){
    print("Password can't be changed" + error.toString());
    //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
  });
}




  }

  static changeProfileImage(
      {required String imgPath, required Function function}) async {
    String id = await PrefData.getUserId();

    FirebaseFirestore.instance
        .collection(adminData)
        .doc(id)
        .update({'image': imgPath}).then((value) {
      showToast("Image updated..");
      function();
    });
  }

  static Future<bool> checkRefId({refId}) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(FirebaseData.topicList)
        .where(FirebaseData.refId, isEqualTo: refId)
        .get();

    if (querySnapshot.size > 0) {
      return false;
    } else {
      return true;
    }
  }

  static Future<int> setCompleteDay() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(FirebaseData.topicList)
        .orderBy('ref_id', descending: true)
        .get();
    if (querySnapshot.size > 0) {
      if (querySnapshot.docs.isNotEmpty) {
        List<DocumentSnapshot> list1 = querySnapshot.docs;
        if (list1.isNotEmpty) {
          TopicModel topicModel = TopicModel.fromFirestore(list1[0]);
          return (topicModel.refId! + 1);
        }
      }
      return 1;
    } else {
      return 1;
    }
  }

  static Future<int> getIndex() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(FirebaseData.quizList)
        .orderBy('index', descending: true)
        .get();
    if (querySnapshot.size > 0) {
      if (querySnapshot.docs.isNotEmpty) {
        List<DocumentSnapshot> list1 = querySnapshot.docs;
        if (list1.isNotEmpty) {
          QuizModel topicModel = QuizModel.fromFirestore(list1[0]);
          return (topicModel.index! + 1);
        }
      }
      return 1;
    } else {
      return 1;
    }
  }
}
