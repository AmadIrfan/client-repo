import 'package:quizapp/model/quiz_model.dart';
import 'package:quizapp/model/topic_model.dart';
import 'package:get/get.dart';

import '../model/history_model.dart';
import '../model/profile_model.dart';

class ObsController extends GetxController {
  RxString answerValue = "".obs;
  RxInt value = 1.obs;
  RxInt index = 0.obs;
  TopicModel? topicModel;
  QuizModel? quizModel;
  ProfileModel? profileModel;
  List<HistoryModel> historyList = [];

  setHistoryList(List<HistoryModel> list) {
    this.historyList = list;
    update();
  }

  setTopicModel(TopicModel model) {
    this.topicModel = model;
    update();
  }

  setQuizModel(QuizModel model) {
    this.quizModel = model;
    update();
  }

  setProfileModel(ProfileModel model) {
    this.profileModel = model;
    update();
  }
}
