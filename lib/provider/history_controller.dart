import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../model/detail_model.dart';
import '../model/topic_model.dart';
import 'data/FirebaseData.dart';
import 'obs_controller.dart';

class HistoryController extends GetxController {
  RxBool isLoading = false.obs;

  RxList<DetailModel> detailList = <DetailModel>[].obs;

  getAllData() async {
    detailList = <DetailModel>[].obs;
    isLoading(true);
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(FirebaseData.topicList)
        .orderBy("ref_id", descending: false)
        .get();
    await getMainList(querySnapshot);
    isLoading(false);
  }

  getMainList(QuerySnapshot querySnapshot) async {
    ObsController controller = Get.find();

    for (int i = 0; i < querySnapshot.docs.length; i++) {
      TopicModel model = TopicModel.fromFirestore(querySnapshot.docs[i]);

      QuerySnapshot q = await FirebaseFirestore.instance
          .collection(FirebaseData.historyList)
          .doc(controller.profileModel!.id!)
          .collection('${FirebaseData.dataList}${model.refId}')
          .get();

      await getList(q);
    }
  }

  Future<void> getList(QuerySnapshot q) async {
    for (int j = 0; j < q.docs.length; j++) {
      DetailModel model = DetailModel.fromFirestore(q.docs[j]);
      detailList.add(model);
    }
  }
}
