
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/model/quiz_model.dart';
import 'package:quizapp/model/topic_model.dart';
import 'package:quizapp/provider/data/FirebaseData.dart';
import 'package:quizapp/utils/Constants.dart';

import 'package:get/get.dart';

import '../../provider/obs_controller.dart';
import '../../theme/color_scheme.dart';
import '../../utils/responsive.dart';
import '../../utils/widgets.dart';
import '../dashboard/file_info_card.dart';
import '../totalquiz/total_question_view.dart';

class QuizView extends StatefulWidget {
  final TopicModel topicModel;

  QuizView({required this.topicModel});

  @override
  _QuizView createState() {
    return _QuizView();
  }
}

class _QuizView extends State<QuizView> {
  @override
  Widget build(BuildContext context) {

    ObsController sideMenuController = Get.find();

    final Size _size = MediaQuery.of(context).size;
    return Builder(builder: (context) {
      return WillPopScope(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: primaryColor,
              title: getFont(widget.topicModel.title!),
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(Icons.arrow_back_rounded,color: Colors.transparent,),
                    onPressed: () {
                 },
                    tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                  );
                },
              ),

            ),
            body: SafeArea(
                child: StreamBuilder<QuerySnapshot>(
              stream:
              FirebaseFirestore.instance
                  .collection(FirebaseData.quizList)
                  .where(FirebaseData.refId, isEqualTo: widget.topicModel.refId!).
              // orderBy(FirebaseData.index,descending: false)
              //     .
                    snapshots(),
              builder: (context, snapshot) {



                print("snapshot------------${snapshot}");


                if (

                    snapshot.connectionState == ConnectionState.active) {
                  print("state===${snapshot.hasData}");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return loaderWidget(context,true);
                }
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.active) {

                  print("snapshot===${snapshot.data!.docs}");
                  List<DocumentSnapshot> list = snapshot.data!.docs;
                  list = list.reversed.toList();
                  return list.isNotEmpty
                      ? ListView.builder(
                    primary: false,
                          padding: EdgeInsets.symmetric( horizontal: Constants.getPaddingForPage()),
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            QuizModel topicModel =
                                QuizModel.fromFirestore(list[index]);
                            return Responsive(
                              mobile: QuizItem(
                                index: index,
                                height: _size.width < 650 ? 240 : 260,
                                quizModel: topicModel,
                                function: () {},
                              ),
                              tablet: QuizItem(
                                quizModel: topicModel,
                                height: 250,
                                index: index,
                                function: () {},
                              ),
                              desktop: QuizItem(
                                quizModel: topicModel,
                                index: index,
                                height: _size.width < 1400 ? 240 : 270,
                                function: () {},
                              ),
                            );
                          },
                        )
                      : Center(
                          child: getFont(
                            'No data',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    color: getFontColor(context),
                                    fontWeight: FontWeight.w600),
                          ),
                        );
                } else {
                  return Container();
                }
              },
            )),
          ),
          onWillPop: () async {
            Get.back();
            sideMenuController.index(Constants.allQuestion);
            return true;
          });
    });
  }
}


