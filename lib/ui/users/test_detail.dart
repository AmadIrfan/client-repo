
import 'package:flutter/material.dart';
import 'package:quizapp/model/history_model.dart';
import 'package:quizapp/provider/data_controller.dart';

import 'package:quizapp/utils/Constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';


import '../../model/option_data.dart';
import '../../provider/obs_controller.dart';
import '../../theme/color_scheme.dart';
import '../../utils/responsive.dart';
import '../../utils/widgets.dart';
import '../dashboard/dashboard_screen.dart';
import '../dashboard/file_info_card.dart';
import 'common_quiz_button_widget.dart';

class TestDetail extends StatefulWidget {
  final DataController dataController;

  TestDetail({required this.dataController});

  @override
  _TestDetail createState() {
    return _TestDetail(dataController: this.dataController);
  }
}

class _TestDetail extends State<TestDetail> {
  final DataController dataController;

  _TestDetail({required this.dataController});


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;


    ObsController obsController = Get.find();




    return obsController.historyList.isNotEmpty
        ? ListView.builder(
      itemCount: obsController.historyList.length,
      itemBuilder: (context, index) {
        HistoryModel model = obsController.historyList[index];
        return Responsive(
          mobile: TestDetailItem(
            index: index,
            height: size.width < 650 ? 240 : 260,
            detailModel: model,
            function: () {},
          ),
          tablet: TestDetailItem(
            detailModel: model,
            height: 250,
            index: index,
            function: () {},
          ),
          desktop: TestDetailItem(
            detailModel: model,
            index: index,
            height: size.width < 1400 ? 240 : 270,
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
            .copyWith(color: getFontColor(context), fontWeight: FontWeight.w600),
      ),
    );

  }
}

class TestDetailItem extends StatelessWidget {
  final double height;
  final HistoryModel detailModel;
  final int index;
  final Function function;
  final ObsController? obsController;

  TestDetailItem(
      {required this.height,
      required this.detailModel,
      required this.index,
      required this.function,
      this.obsController});

  @override
  Widget build(BuildContext context) {
    Constants.setupSize(context);


    int quizType=detailModel.quizType!;

    List<String> result = [];
    if(quizType==0){
      OptionData  optionData = detailModel.optionData!;
      result = getOptionData(optionData);
    }else{
      result.add('True');
      result.add('False');
    }


    Decoration decoration = getDefaultDecoration(
        radius: getPercentSize(height, 3), borderColor: Colors.grey.shade200);



    return Container(
      // height: height,
      margin: EdgeInsets.symmetric(
          vertical: getPercentSize(height, 7), horizontal: defaultHorPadding),
      padding: EdgeInsets.all(getPercentSize(height, 6)),
      decoration: getDefaultDecoration(
          radius: getPercentSize(height, 5),
          borderColor: borderColor,
          borderWidth: 1,
          bgColor: Colors.white),



      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          Image.network(
            height: 160.h,
            width: 160.h,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return getProgressDialog(context);
              }
            },

            errorBuilder: (context, error, stackTrace) {
              return getErrorBuilder();
            },
            detailModel.image!,


          ).marginOnly(bottom: 15.h),


          getDefaultFont("Question:", 15, Colors.grey,
              fontWeight: FontWeight.normal).marginOnly(bottom: 10.h),


          getDefaultFont(detailModel.question!, 22, Colors.black,
              fontWeight: FontWeight.w600).marginOnly(bottom: 15.h),


          // GridView.count(
          //   crossAxisCount: _crossAxisCount,
          //   childAspectRatio: _aspectRatio,
          //   shrinkWrap: true,
          //   crossAxisSpacing: _crossAxisSpacing,
          //   mainAxisSpacing: 20.h,
          //   primary: false,
          //   padding: EdgeInsets.symmetric(vertical: 20.h, ),
          //   children: List.generate(result.length, (index) {
          //     Color? color = null;
          //
          //     if(result[index].trim() == detailModel.answer.toString().trim())
          //     {
          //       color=greenColor;
          //     }else if (result[index].trim() == detailModel.selectedAnswer.toString().trim()){
          //       color=redColor;
          //     }
          //
          //
          //     return CommonQuizButtonWidget(optionType: detailModel.quizType == 1?'':getOptionType(index),
          //       option: result[index],
          //       isTrue: false,
          //       color:(color==null)?null:color,
          //       isSelected: false,);
          //   }),
          // ),


          ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {

                Color? color;

                if(result[index].trim() == detailModel.answer.toString().trim())
                {
                  color=greenColor;
                }else if (result[index].trim() == detailModel.selectedAnswer.toString().trim()){
                  color=redColor;
                }


                return Container(
                  // height: cellHeight,
                  decoration: decoration,
                  padding: EdgeInsets.symmetric(
                      horizontal: getPercentSize(height, 5),vertical:getPercentSize(height, 5)),
                  margin:
                  EdgeInsets.only(bottom: getPercentSize(height, 5)),
                  alignment: Alignment.centerLeft,
                  child: getDefaultFont(
                      result[index]
                          .trim(),
                      getPercentSize(height, 7),
                      color ?? Colors.black,

                      fontWeight: FontWeight.w500),
                );
              },
              itemCount: result.length),


          // Responsive.isDesktop(context)?
          //     Row(
          //        children: [
          //          Expanded(child: Container(),flex: 1,),
          //          Expanded(child: getListView(result),flex: 1,),
          //          Expanded(child: Container(),flex: 1,)
          //        ],
          //     )
          //     :getListView(result),







        Align(
          alignment: Alignment.topRight,
          child: getSelectedButton(detailModel.type!, context),
        )



        ],
      ),
    );
  }


  getListView(var result){
    return     ListView.builder(
      itemCount: result.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {


        Color? color;

        if(result[index].trim() == detailModel.answer.toString().trim())
        {
          color=greenColor;
        }else if (result[index].trim() == detailModel.selectedAnswer.toString().trim()){
          color=redColor;
        }


        return CommonQuizButtonWidget(optionType: detailModel.quizType == 1?'':getOptionType(index),
          option: result[index],
          isTrue: false,
          color:(color==null)?null:color,
          isSelected: false,);
      },);
  }
  getSelectedButton(int type,BuildContext context){
    if(type == wrongType){
      return getWrongButton();
    }else  if(type == correct){
      return getCorrectButton();
    }else{
      return  getSkipButton(context);
    }
  }

  getCommonResultButton(
      {required Color bgColor, required String text, required String count}) {
    return Column(
      children: [
        Container(
          height: 40.h,
          width: 40.h,
          decoration: getDefaultDecoration(
              radius: 10.r,
              borderColor: borderColor,
              borderWidth: 1,
              bgColor: bgColor),
          child: Center(
            child: getCustomFont(count, 20.sp,
                    bgColor == skipColor ? Colors.black : Colors.white, 1,
                    fontWeight: FontWeight.w500)
                .marginOnly(bottom: 5.h),
          ),
        ).marginOnly(bottom: 7.h),
        getCustomFont(text, 15, Colors.black, 1, fontWeight: FontWeight.w500)
            .marginOnly(bottom: 5.h),
      ],
    ).marginOnly(right: 4.w);
  }
}
getOptionData(OptionData optionData){
  List<String> result=[];
  result.add(optionData.optionA!);
  result.add(optionData.optionB!);
  result.add(optionData.optionC!);
  result.add(optionData.optionD!);
  return result;
}

getOptionType(int position) {
  if (position == 0) {
    return "A.";
  } else if (position == 1) {
    return "B.";
  } else if (position == 2) {
    return "C.";
  } else if (position == 3) {
    return "D.";
  } else {
    return "A.";
  }
}
