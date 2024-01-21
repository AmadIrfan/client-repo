import 'package:flutter/material.dart';
import 'package:quizapp/main.dart';
import 'package:quizapp/model/quiz_model.dart';
import 'package:quizapp/model/topic_model.dart';
import 'package:quizapp/provider/obs_controller.dart';
import 'package:quizapp/ui/category/add_category_view.dart';
import 'package:quizapp/ui/category/edit_category_view.dart';
import 'package:quizapp/ui/quiz/edit_question_view.dart';
import 'package:quizapp/ui/splash.dart';
import 'package:quizapp/ui/totalquiz/total_quiz_view.dart';

import '../provider/data_controller.dart';
import '../ui/quiz/quiz_view.dart';

var appRoutes = {

  KeyUtil.quizList: (context) => QuizView(topicModel: ModalRoute.of(context)?.settings.arguments as TopicModel),
  KeyUtil.home: (context) => MyHomePage(),
  KeyUtil.addCategory: (context) => AddCategoryPage(topicModel: ModalRoute.of(context)?.settings.arguments as TopicModel
  ,obsController: ModalRoute.of(context)?.settings.arguments as ObsController),
  KeyUtil.editCategory: (context) => EditCategoryPage(topicModel: ModalRoute.of(context)?.settings.arguments as TopicModel
      ,obsController:  ModalRoute.of(context)?.settings.arguments as ObsController,dataController:
      ModalRoute.of(context)?.settings.arguments as DataController),
  KeyUtil.loginPage: (context) => LoginPage(),
  KeyUtil.editQuiz: (context) => EditQuestionPage(ModalRoute.of(context)?.settings.arguments as QuizModel),
  KeyUtil.splash: (context) => SplashScreen(),
  KeyUtil.totalQuiz: (context) => TotalQuizView(),

};

class KeyUtil {

  static const String quizList = '/QuizPage';
  static const String home = '/MyHomePage';
  static const String addCategory = '/AddCategoryPage';
  static const String editCategory = '/EditCategory';
  static const String loginPage = '/LoginPage';
  static const String adminPage = '/AdminPage';
  static const String signUpPage = '/SignUpPage';
  static const String splash = '/splash';
  static const String editQuiz = '/editQuiz';
  static const String totalQuiz = '/totalQuiz';


}
