import 'package:flutter/material.dart';
import 'package:quizapp/provider/obs_controller.dart';
import 'package:quizapp/provider/data_controller.dart';
import 'package:quizapp/theme/color_scheme.dart';
import 'package:get/get.dart';

import '../../model/topic_model.dart';
import '../../utils/responsive.dart';
import '../../utils/widgets.dart';



class CustomDropDown extends StatelessWidget {
  final Function? onChanged;
  final int? value;

  final  ObsController obsController;
  CustomDropDown(this.obsController,{
    Key? key,
    this.onChanged,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;


    return GetBuilder<DataController>(
      init: DataController(),
      builder: (dataController) {

        if (dataController.categoryList.isNotEmpty) {
          TopicModel model =
          TopicModel.fromFirestore(dataController.categoryList[0]);


          if(value==null) {
            onChanged!(model.refId!);
            obsController.value(model.refId!);
          }else{
            onChanged!(value);
            obsController.value(value);
          }
        }


        return dataController.topicList.isNotEmpty
            ? Obx((){
          return Responsive(
            mobile: getDropDown(
              dataController: dataController,
              height: size.width < 650 ? 50 : 70,  context: context
            ),
            tablet: getDropDown(

              dataController: dataController,
              height:  60,
              context: context
            ),
            desktop:getDropDown(
              dataController: dataController,
              height: size.width < 1400 ? 50 : 60,  context: context
            ),
          );
        })
            : Container();
      },
    );
  }
  getDropDown(
      {required DataController dataController,
        required double height,required BuildContext context}) {

    return Container(
      height: height,
      margin: EdgeInsets.symmetric(vertical: getPercentSize(height,20)),
      padding: EdgeInsets.symmetric(horizontal: getPercentSize(height,25)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.transparent,width: 1),
          color: getCardColor(context)
      ),
      alignment: Alignment.centerLeft,
      child: DropdownButton<int>(
        hint: getFont('Select Category'),
        isExpanded: true,
        items: dataController.categoryList.map((val) {
          TopicModel model = TopicModel.fromFirestore(val);
          return DropdownMenuItem<int>(
            value: model.refId,
            child: getFont(model.title! ,style: TextStyle(color: getFontColor(context))),
          );
        }).toList(),
        value: obsController.value.value,
        underline: Container(),
        onChanged: (value) {
          onChanged!(value);
          obsController.value(value);
        },
      ),
    );
  }

}

