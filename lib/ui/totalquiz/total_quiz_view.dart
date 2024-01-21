import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/model/quiz_model.dart';
import 'package:quizapp/provider/data/FirebaseData.dart';
import 'package:quizapp/ui/totalquiz/total_question_view.dart';

import '../../theme/color_scheme.dart';
import '../../utils/responsive.dart';
import '../../utils/widgets.dart';
import '../dashboard/file_info_card.dart';

class TotalQuizView extends StatefulWidget {
  @override
  _TotalQuizView createState() {
    return _TotalQuizView();
  }
}

class _TotalQuizView extends State<TotalQuizView> {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Builder(builder: (context) {
      return WillPopScope(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: primaryColor,
              title: getFont('Total Quiz'),
            ),
            body: SafeArea(
                child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection(FirebaseData.quizList).
              orderBy(FirebaseData.index,descending: true).
              snapshots(),
              builder: (context, snapshot) {
                print("state1212121212===${snapshot.connectionState}");

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return loaderWidget(context,true);
                }
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.active) {
                  List<DocumentSnapshot> list = snapshot.data!.docs;
                  list = list.reversed.toList();
                  return list.isNotEmpty
                      ? ListView.builder(
                    primary: false,
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
                                    color:getFontColor(context),
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
            Navigator.of(context).pop();
            return true;
          });
    });
  }
}

