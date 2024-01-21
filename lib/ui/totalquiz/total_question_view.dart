import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/model/quiz_model.dart';
import 'package:quizapp/provider/data/FirebaseData.dart';
import 'package:quizapp/provider/data_controller.dart';
import 'package:quizapp/ui/totalquiz/drop_down.dart';
import 'package:quizapp/utils/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../provider/obs_controller.dart';
import '../../theme/color_scheme.dart';
import '../../utils/pref_data.dart';
import '../../utils/responsive.dart' as res;
import '../../utils/Constants.dart';
import '../../utils/widgets.dart';
import '../dashboard/dashboard_screen.dart';
import '../dashboard/file_info_card.dart';

class TotalQuestionView extends StatefulWidget {
  final ObsController obsController;
  final DataController dataController;

  TotalQuestionView(
      {required this.obsController, required this.dataController});

  @override
  _TotalQuestionView createState() {
    return _TotalQuestionView();
  }
}

List<DocumentSnapshot> list = [];

class _TotalQuestionView extends State<TotalQuestionView> {
  ValueNotifier<int> refId = ValueNotifier(-1);
  final ScrollController _controller = ScrollController();

  RxInt position = 0.obs;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Column(
      children: [
        SizedBox(
          height: Constants.getPaddingForPage() / 2,
        ),
        Row(
          children: [
            Expanded(
              flex: 4,
              child: getFont(
                'Questions',
                style:  res.Responsive.isMobile(context) ?
                Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: getFontColor(context),
                    fontWeight: FontWeight.w700)    :Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: getFontColor(context),
                    fontWeight: FontWeight.w700),
              ),
            ),
            Expanded(
              flex: res.Responsive.isDesktop(context) ? 1 : 2,
              child: DropDown(widget.obsController,
                  dataController: widget.dataController, onChanged: (value) {
                if (value != refId.value) {
                  refId.value = value;
                  position.value = 0;
                }
              }, currentValue: refId),
            ),
            SizedBox(
              width: 20.h,
            ),
            getDefaultButton(
              context,
              'Add New Question',
              () async {
                PrefData.checkAccess(function: (){widget.obsController.index(Constants.addQuestionView);});
              },
            )
          ],
        ).marginSymmetric(horizontal: Constants.getPaddingForPage()),

        const SizedBox(
          height: defaultHorPadding,
        ),
        // Container(
        //   margin: EdgeInsets.symmetric(horizontal: defaultHorPadding),
        //   child: Row(
        //     children: [
        //       Expanded(
        //         child: DropDown(widget.obsController,
        //             dataController: widget.dataController, onChanged: (value) {
        //           if (value != refId.value) {
        //             refId.value = value;
        //             position.value = 0;
        //           }
        //         }, currentValue: refId),
        //         flex: res.Responsive.isDesktop(context) ? 4 : 2,
        //       ),
        //       SizedBox(
        //         width: 15,
        //       ),
        //       Expanded(
        //         child: getAddButton(),
        //         flex: 1,
        //       ),
        //     ],
        //   ),
        // ),
        Expanded(
            child: ValueListenableBuilder(
          valueListenable: refId,
          builder: (context, value, child) {
            return StreamBuilder<QuerySnapshot>(
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return loaderWidget(context,true);
                }
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.active) {
                  List<DocumentSnapshot> list = snapshot.data!.docs;
                  // List<DocumentSnapshot> list = sortedList(snapshot.data!.docs);



                  double i = list.length / 10;
                  //
                  // int d = list.length - (10 * i.toInt());
                  //
                  // if (d > 0) {
                  //   i = i + 1;
                  // }

                  int d = list.length - (10 * i.toInt()).toInt();

                  if (d > 0) {
                    i = i + 1;
                  }

                  print("list===$i");

                  print("list===${list.length}===$i===$d====${refId.value}");

                  return list.isNotEmpty
                      ? Obx(() {
                        List<DocumentSnapshot> paginationList = [];
                        paginationList = list
                            .skip(position.value * 10)
                            .take(10)
                            .toList();
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              flex: 1,
                              child: ListView.builder(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        Constants.getPaddingForPage()),
                                controller: _controller,
                                primary: false,
                                addAutomaticKeepAlives: true,
                                itemCount: paginationList.length,
                                itemBuilder: (context, index) {
                                  QuizModel topicModel =
                                      QuizModel.fromFirestore(
                                          paginationList[index]);
                                  return res.Responsive(
                                    mobile: QuizItem(
                                      index: index,
                                      obsController: widget.obsController,
                                      height:
                                          _size.width < 650 ? 240 : 260,
                                      quizModel: topicModel,
                                      function: () {},
                                    ),
                                    tablet: QuizItem(
                                      quizModel: topicModel,
                                      obsController: widget.obsController,
                                      height: 250,
                                      index: index,
                                      function: () {},
                                    ),
                                    desktop: QuizItem(
                                      quizModel: topicModel,
                                      obsController: widget.obsController,
                                      index: index,
                                      height:
                                          _size.width < 1400 ? 240 : 270,
                                      function: () {},
                                    ),
                                  );
                                },
                              ),
                            ),
                            Container(
                              height: 50.h,
                              width: double.infinity,
                              margin: EdgeInsets.only(
                                  left: Constants.getPaddingForPage(),
                                  bottom: 10.h,
                                  right: Constants.getPaddingForPage()),
                              decoration: getDefaultDecoration(
                                  bgColor: getBackgroundColor(context),
                                  radius: 5.r),
                              child: Center(
                                child: SingleChildScrollView(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // InkWell(
                                      //     onTap: () {
                                      //       if (position.value > 0) {
                                      //         position.value =
                                      //             position.value - 1;
                                      //       }
                                      //     },
                                      //     child: Icon(
                                      //       Icons.chevron_left,
                                      //       color: primaryColor,
                                      //     )),
                                      // SizedBox(
                                      //   width:
                                      //       getWidthPercentSize(context, 0.8),
                                      // ),
                                      // ListView.builder(itemCount: 50,primary: true  ,shrinkWrap: true,scrollDirection:'

                                      Expanded(
                                          child: Align(
                                        alignment: Alignment.centerRight,
                                        child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: List.generate(
                                                i.toInt(),
                                                (index) => InkWell(
                                                      child: Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    getHeightPercentSize(
                                                                        context,
                                                                        0.7)),
                                                        height: 22.h,
                                                        width: 22.h,
                                                        decoration: BoxDecoration(
                                                            shape: BoxShape
                                                                .circle,
                                                            color: position
                                                                        .value ==
                                                                    index
                                                                ? primaryColor
                                                                : getBorderColor(
                                                                    context)),
                                                        child: Center(
                                                          child: getFont(
                                                            '${index + 1}',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                    fontSize:
                                                                        12.h,
                                                                    color: position.value ==
                                                                            index
                                                                        ? Colors
                                                                            .white
                                                                        : getFontColor(
                                                                            context),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                          ),
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        position.value =
                                                            index;
                                                        _controller.jumpTo(0);
                                                      },
                                                    )),
                                          ),
                                        ),
                                      )),

                                      SizedBox(
                                        width:
                                            getWidthPercentSize(context, 0.8),
                                      ),
                                      InkWell(
                                          onTap: () {
                                            print(
                                                "posi===${position.value}===${i - 1}");
                                            if (position.value <
                                                (i.toInt() - 1)) {
                                              position.value =
                                                  position.value + 1;
                                            }
                                          },
                                          child: Icon(
                                            Icons.chevron_right,
                                            color: primaryColor,
                                          )),
                                    ],
                                  ).marginOnly(right: defaultHorPadding),
                                ),
                              ),
                            ),
                          ],
                        );
                      })
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
              stream: refId.value >= 0
                  ? FirebaseFirestore.instance
                      .collection(FirebaseData.quizList)
                  .orderBy(FirebaseData.index, descending: true)
                      .where(FirebaseData.refId, isEqualTo: refId.value)
                      .snapshots()
                  : FirebaseFirestore.instance
                      .collection(FirebaseData.quizList)
                      .orderBy(FirebaseData.index, descending: true)
                      .snapshots(),
            )

                ;
          },
        ))
      ],
    );
  }



  sortedList(List<DocumentSnapshot> myList){
   return myList..sort((a, b) {


      QuizModel topicModel =
      QuizModel.fromFirestore(a);
      QuizModel topicModel1 =
      QuizModel.fromFirestore(b);

     return topicModel.index!.compareTo(topicModel1.index!);
    });

  }
  getAddButton() {
    final Size size = MediaQuery.of(context).size;

    return res.Responsive(
      mobile: getButton(size.width < 650 ? 50 : 70, 'Add New Question', () {
        PrefData.checkAccess(function: () {
          widget.obsController.index(Constants.addQuestionView);
        });
      }, context, isMobile: true),
      tablet: getButton(60, 'Add New Question', () {
        PrefData.checkAccess(function: () {
          widget.obsController.index(Constants.addQuestionView);
        });
      }, context, isMobile: true),
      desktop: getButton(size.width < 1400 ? 50 : 60, 'Add New Question', () {
        PrefData.checkAccess(function: () {
          widget.obsController.index(Constants.addQuestionView);
        });
      }, context, isMobile: true),
    );
  }
}

List<DocumentSnapshot> _paginatedProductData = [];

List<DocumentSnapshot> _products = [];

bool showLoadingIndicator = false;

const double dataPagerHeight = 70.0;

class QuizItem extends StatelessWidget {
  final double height;
  final QuizModel quizModel;
  final int index;
  final Function function;
  final ObsController? obsController;

  QuizItem(
      {required this.height,
      required this.quizModel,
      required this.index,
      required this.function,
      this.obsController});

  @override
  Widget build(BuildContext context) {
    double subHeight = getPercentSize(height, 17);
    double cellHeight = getPercentSize(height, 13);

    Decoration decoration = getDefaultDecoration(
        radius: getPercentSize(height, 3), borderColor: Colors.transparent,bgColor: getCardColor(context));

    return InkWell(
      child: Container(
        // height: height,
        margin: EdgeInsets.symmetric(
          vertical: getPercentSize(height, 7),

        ),
        padding: EdgeInsets.all(getPercentSize(height, 6)),
        decoration: getDefaultDecoration(
            radius: getPercentSize(height, 5),
            borderColor: Colors.transparent,
            borderWidth: 1,
            bgColor: getBackgroundColor(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getDefaultFont('${(index + 1)}.', getPercentSize(subHeight, 34),
                    getFontColor(context),
                    fontWeight: FontWeight.bold),


                SizedBox(width: 10.h,),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    quizModel.image == null || quizModel.image!.isEmpty
                        ? Container(
                            color: Colors.grey.shade200,
                          )
                        : Image.network(
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: getPercentSize(height, 30),
                                width: getPercentSize(height, 30),
                                color: Colors.grey.shade200,
                              );
                            },
                            quizModel.image!,
                            height: getPercentSize(height, 30),
                            width: getPercentSize(height, 30),
                          ).marginOnly(bottom: 10.h),
                    getDefaultFont(quizModel.question!,
                        getPercentSize(subHeight, 34), getFontColor(context),
                        fontWeight: FontWeight.w400),

                    SizedBox(
                      height: getPercentSize(height, 5),
                    ),
                    quizModel.type == 1
                        ? Container()
                        : ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                // height: cellHeight,
                                decoration: decoration,
                                padding: EdgeInsets.symmetric(
                                    horizontal: getPercentSize(cellHeight, 20),
                                    vertical: getPercentSize(subHeight, 20)),
                                margin: EdgeInsets.only(
                                    bottom: getPercentSize(height, 5)),
                                alignment: Alignment.centerLeft,
                                child: getDefaultFont(
                                    '${getOption(index)}. ${quizModel.optionList![index]}'
                                        .trim(),
                                    getPercentSize(cellHeight, 40),
                                    getFontColor(context),
                                    // 1,
                                    fontWeight: FontWeight.w400),
                              );
                            },
                            itemCount: quizModel.optionList!.length),
                    SizedBox(
                      height: getPercentSize(height, 1),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getCustomFont('Correct Answer:', getPercentSize(height, 6),
                            getPrimaryColor(context), 1,
                            textAlign: TextAlign.start, fontWeight: FontWeight.w600),
                        Expanded(
                          child: Container(
                            // decoration: decoration,
                            margin: EdgeInsets.only(left: getPercentSize(height, 2)),
                            alignment: Alignment.topLeft,

                            child: getDefaultFont('${quizModel.answer}'.trim(),
                                getPercentSize(height, 6), primaryColor,
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    )

                  ],
                )),

                // new Spacer(),
                InkWell(
                  onTap: () {
                    PrefData.checkAccess(function: () {
                      if (obsController != null) {
                        obsController!.index(Constants.editQuestion);
                        obsController!.setQuizModel(quizModel);
                      } else {
                        Get.toNamed(KeyUtil.editQuiz, arguments: quizModel)!
                            .then((value) {
                          function();
                        });
                      }
                    });
                  },
                  child: Image.asset("${Constants.assetIconPath}edit.png",height: getPercentSize(height, 8),color: getIconColor(context),),

                ),
                15.width,
                InkWell(
                  onTap: () {
                    PrefData.checkAccess(function: () {
                      getCommonDialog(
                          context: context,
                          title: 'Do you want to delete?',
                          subTitle: 'Delete',
                          function: () {
                            FirebaseData.deleteQuestion(
                                id: quizModel.id!,
                                function: () {

                                  function();
                                });
                          });
                    });
                  },
                  child: Image.asset("${Constants.assetIconPath}delete.png",height: getPercentSize(height, 8),color: getIconColor(context),),

                )
              ],
            ),

            // Container(
            //     // height: subHeight,
            //     decoration: decoration,
            //     padding: EdgeInsets.symmetric(
            //         horizontal: getPercentSize(subHeight, 15),
            //         vertical: getPercentSize(subHeight, 20)),
            //     alignment: Alignment.centerLeft,
            //     child: getDefaultFont('${(index + 1)}. ${quizModel.question!}',
            //         getPercentSize(subHeight, 34), primaryColor,
            //         fontWeight: FontWeight.w500)),
            // SizedBox(
            //   height: getPercentSize(height, 6),
            // ),

          ],
        ),
      ),
    );
  }

  getOption(int optionType) {
    if (optionType == 0) {
      return 'A';
    } else if (optionType == 1) {
      return 'B';
    } else if (optionType == 2) {
      return 'C';
    } else {
      return 'D';
    }
  }
}

class CustomSliverChildBuilderDelegate extends SliverChildBuilderDelegate
    with DataPagerDelegate, ChangeNotifier {
  CustomSliverChildBuilderDelegate(builder) : super(builder);

  @override
  int get childCount => _paginatedProductData.length;

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int endIndex = oldPageIndex + newPageIndex;

    if (endIndex > _products.length) {
      endIndex = _products.length - 1;
    }

    await Future.delayed(const Duration(milliseconds: 2000));
    _paginatedProductData =
        _products.getRange(oldPageIndex, endIndex).toList(growable: false);

    notifyListeners();
    return true;
  }

  @override
  bool shouldRebuild(covariant CustomSliverChildBuilderDelegate oldDelegate) {
    return true;
  }
}
