// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:quizapp/provider/obs_controller.dart';
import 'package:quizapp/provider/data_controller.dart';
import 'package:quizapp/theme/color_scheme.dart';

import '../../model/topic_model.dart';
import '../../utils/responsive.dart';
import '../../utils/widgets.dart';



class DropDown extends StatelessWidget {
  final Function? onChanged;
   ValueNotifier<int>? currentValue;


  final  ObsController obsController;
  DropDown(this.obsController,{
    Key? key,
    this.onChanged,
    this.currentValue,
   required this.dataController,

  }) : super(key: key);

  final DataController dataController;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Container(
      child: dataController.topicList.isNotEmpty
          ? Responsive(
        mobile: getDropDown(
          dataController: dataController,  context: context,

          height: _size.width < 650 ? 35 : 55,
        ),
        tablet: getDropDown(
          dataController: dataController,
          height:  45,  context: context
        ),
        desktop:getDropDown(
          dataController: dataController,
          height: _size.width < 1400 ? 35 : 45,
          context: context
        ),
      )
          : Container(),
    );
  }
  getDropDown(
      {required DataController dataController,
        required double height,required BuildContext context}) {

    return Container(
      height: height,
      // margin: EdgeInsets.symmetric(vertical: getPercentSize(height,20)),
      padding: EdgeInsets.only(left: getPercentSize(height,15),right: getPercentSize(height,37)),
      decoration: getDefaultDecoration(bgColor: getBackgroundColor(context),radius:getPercentSize(height,10),
      borderColor: Colors.transparent,borderWidth: 0.5),
      alignment: Alignment.centerLeft,
      child: ValueListenableBuilder(
        valueListenable: currentValue!,
        builder: (context, v, child) {
          return DropdownButton<int>(
            hint: getFont('Select Category'),
            isExpanded: true,
            items: dataController.topicList.map((val) {
              TopicModel model = val;
              return DropdownMenuItem<int>(
                value: model.refId,
                child: getFont(val.refId == -1?'All':model.title!),
              );
            }).toList(),
            value: currentValue!.value,
            underline: Container(),
            onChanged: (v) {
              onChanged!(v);
              currentValue!.value = v as int ;
            },
          );
        },
      ),
    );
  }

}

