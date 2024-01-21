
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quizapp/provider/data_controller.dart';

import 'package:quizapp/utils/Constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../model/detail_model.dart';

import '../../model/fetch_history_data.dart';
import '../../provider/history_controller.dart';
import '../../provider/obs_controller.dart';
import '../../theme/color_scheme.dart';
import '../../utils/responsive.dart';
import '../../utils/widgets.dart';
import '../dashboard/dashboard_screen.dart';
import '../dashboard/file_info_card.dart';

class TestList extends StatefulWidget {
  final DataController dataController;

  TestList({required this.dataController});

  @override
  _TestList createState() {
    return _TestList(dataController: this.dataController);
  }
}

class _TestList extends State<TestList> {
  final DataController dataController;

  _TestList({required this.dataController});

  HistoryController controller = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    controller.getAllData();




    return Obx(() => controller.detailList.isNotEmpty
        ? ListView.builder(
      itemCount: controller.detailList.length,
            itemBuilder: (context, index) {
              DetailModel model = controller.detailList[index];
              return Responsive(
                mobile: TestItem(
                  index: index,
                  height: _size.width < 650 ? 240 : 260,
                  detailModel: model,
                  function: () {},
                ),
                tablet: TestItem(
                  detailModel: model,
                  height: 250,
                  index: index,
                  function: () {},
                ),
                desktop: TestItem(
                  detailModel: model,
                  index: index,
                  height: _size.width < 1400 ? 240 : 270,
                  function: () {},
                ),
              );
            },
          )
        : controller.isLoading.value
            ? loaderWidget(context,true)
            : Center(
              child: getFont(
                  'No data',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: getFontColor(context), fontWeight: FontWeight.w600),
                ),
            ));

  }
}

class TestItem extends StatelessWidget {
  final double height;
  final DetailModel detailModel;
  final int index;
  final Function function;
  final ObsController? obsController;

  TestItem(
      {required this.height,
      required this.detailModel,
      required this.index,
      required this.function,
      this.obsController});

  @override
  Widget build(BuildContext context) {
    Constants.setupSize(context);

    FetchHistoryData historyData =
    FetchHistoryData.fromJson(jsonDecode(detailModel.list!));

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
          Row(
            children: [
              getCustomFont('Date: ', 18, Colors.black, 1,
                  fontWeight: FontWeight.w500),
              Expanded(
                child: getCustomFont(detailModel.date!, 18, Colors.grey, 1,
                    fontWeight: FontWeight.normal),
              )
            ],
          ).marginOnly(bottom: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getCustomFont('Time Taken: ', 18, Colors.black, 1,
                  fontWeight: FontWeight.w500),
              Expanded(
                child: getCustomFont(
                    '${getMinute(detailModel.time!)} min ${getSeconds(detailModel.time!)} sec',
                    18,
                    Colors.grey,
                    1,
                    fontWeight: FontWeight.normal),
              )
            ],
          ).marginOnly(bottom: 22.h),


          Row(
            children: [
              getCommonResultButton(
                  bgColor: greenColor,
                  text: "Right",
                  count: detailModel.right.toString()),
              getCommonResultButton(
                  bgColor: skipColor,
                  text: "Skipped",
                  count: detailModel.skip.toString()),
              getCommonResultButton(
                  bgColor: redColor,
                  text: "Wrong",
                  count: detailModel.wrong.toString()),
              Expanded(child: Container()),
              InkWell(
                onTap: (){

                  if(historyData.list!.isNotEmpty) {
                    ObsController sideMenuController = Get.find();
                    sideMenuController.setHistoryList(historyData.list!);
                    sideMenuController.index(Constants.testDetail);
                  }else{
                    showToast("No data found");
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 7.h),
                  decoration: getDefaultDecoration(
                      radius: 5.r,
                      borderColor: Colors.black,
                      borderWidth: 1,
                      bgColor: Colors.transparent),
                  child: Center(
                    child: getCustomFont("Detail", 18.sp, Colors.black, 1,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
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
