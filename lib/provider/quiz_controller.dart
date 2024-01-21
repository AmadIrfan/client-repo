import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../model/topic_model.dart';
import 'data/FirebaseData.dart';



class QuizController extends GetxController{
  List<DocumentSnapshot> list=[];

  final TopicModel topicModel;
  QuizController({required this.topicModel});
  @override
  void onInit() {
    fetchData();

    super.onInit();
  }

  void fetchData( ) async {
    list=[];
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(FirebaseData.quizList).where(FirebaseData.refId,isEqualTo: topicModel.refId!)
          .orderBy(FirebaseData.index,descending: false)
          .get();

      if (querySnapshot.size > 0) {
        if (querySnapshot.docs.isNotEmpty) {
          List<DocumentSnapshot> list1 = querySnapshot.docs;
          if(list1.isNotEmpty){
            list = list1;
            list = list.reversed.toList();
            update();
          }
        }
      }

  }


}