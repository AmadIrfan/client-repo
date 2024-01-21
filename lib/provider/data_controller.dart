import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizapp/model/topic_model.dart';
import 'package:get/get.dart';

import 'data/FirebaseData.dart';



class DataController extends GetxController{
  RxBool isLoading = true.obs;
  List<DocumentSnapshot> categoryList=[];
  List<TopicModel> topicList=[];

  List<DocumentSnapshot> quizList=[];
  List<DocumentSnapshot> userList=[];

  @override
  void onInit() {
    fetchData();
    fetchUserData();
    fetchQuizData();

    super.onInit();
  }





  void fetchData( ) async {


    categoryList=[];
    topicList=[];
    topicList.add(new TopicModel(refId: -1));
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(FirebaseData.topicList)
          .get();

      if (querySnapshot.size > 0) {
        if (querySnapshot.docs.isNotEmpty) {
          List<DocumentSnapshot> list1 = querySnapshot.docs;
          if(list1.isNotEmpty){
            categoryList = list1;

            for(int i=0;i<categoryList.length;i++){
              topicList.add(TopicModel.fromFirestore(categoryList[i]));
            }



            update();
          }
        }
      }
  }

  void fetchQuizData( ) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(FirebaseData.quizList)
        .get();

    if (querySnapshot.size > 0) {
      if (querySnapshot.docs.isNotEmpty) {
        List<DocumentSnapshot> list1 = querySnapshot.docs;
        if(list1.isNotEmpty){
          quizList = list1;
          update();
        }
      }
    }

  }
  void fetchUserData( ) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(FirebaseData.loginData)
        .get();
    if (querySnapshot.size > 0) {
      if (querySnapshot.docs.isNotEmpty) {
        List<DocumentSnapshot> list1 = querySnapshot.docs;
        if(list1.isNotEmpty){
          userList = list1;

          print("user====${userList.length}");
          update();
        }
      }
    }
  }

}